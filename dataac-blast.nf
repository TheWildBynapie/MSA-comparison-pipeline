#!/usr/bin/env nextflow
//e.g:
//nextflow data-acquisition-blast.nf -c dataac-blast.config

include { seqkit_grep; seqtk_sample } from './data-acquisition.nf'

/* sources: csv_path:searchTerm:queryLength
 * ranges: minPID:maxPID
 */
params {
    sources: List<String> = ['data/raw/results.csv:Seq:500']
    ranges: List<String> = ['40:60']
    sampleSize: Integer = 50
    minSeqCount: Integer = 10
}

workflow {
    main:

    source_ch = channel.fromList(params.sources)
        .map { entry ->
            def (csvPath, searchTerm, qlen) = entry.split(':', 3)
            def csvFile = file(csvPath)
            // Companion FASTA lives alongside the CSV, same basename -- matches filter_fasta.py's own path logic
            def fastaFile = file(csvPath.replaceAll(/\.csv$/, '.fasta'))
            tuple(csvFile, fastaFile, searchTerm, qlen as Double)
        }

    range_ch = channel.fromList(params.ranges)
        .map { r ->
            def (minPID, maxPID) = r.split(':', 2)
            tuple(minPID as Double, maxPID as Double)
        }

    // Every source x every PID range
    combos = source_ch.combine(range_ch)
        .map { csvFile, fastaFile, searchTerm, qlen, minPID, maxPID ->
            tuple(csvFile, fastaFile, qlen, minPID, maxPID, searchTerm)
        }

    filter_by_pid(file('non-nextflow/filter_fasta.py'), combos)

    seqkit_grep(filter_by_pid.out)
    seqtk_sample(seqkit_grep.out, params.sampleSize)

    filtered_output = seqtk_sample.out
    .filter { fasta ->
        fasta.readLines().count { header -> header.startsWith('>') } >= params.minSeqCount
    }

    publish:
    seqtk_sample = filtered_output
}

output {
    seqtk_sample {
        path 'seqkit'
    }
}

process filter_by_pid {
    tag "${csvFile.baseName}_PID${minPID.intValue()}to${maxPID.intValue()}"

    input:
    path filteringpyfile
    tuple path(csvFile), path(fastaFile), val(qlen), val(minPID), val(maxPID), val(searchTerm)

    output:
    tuple path("${csvFile.baseName}_PID${minPID.intValue()}to${maxPID.intValue()}.fasta"), val(searchTerm)

    script:
    """
    python3 ${filteringpyfile} \\
        -i ${csvFile} \\
        -mid ${minPID} \\
        -mad ${maxPID} \\
        -qlen ${qlen} \\
        -o ${csvFile.baseName}_PID${minPID.intValue()}to${maxPID.intValue()}.fasta
    """
}