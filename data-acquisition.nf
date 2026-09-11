#!/usr/bin/env nextflow
//e.g:
//nextflow data-acquisition.nf -c dataac.config --seqkitToSearch "Cytochrome c oxidase subunit I"


/*You need to specify what seqkit must look for in the headers
* default seqtk sample size is 50
* 
* Don't forget to override the default config file: -c "dataac.config"
*/
params {
    fasta: List<String> = ['data/sequence.fasta']
    sampleSize: Integer = 50
    seqkitToSearch: String
}

workflow {
    main:

    input_ch = channel.fromList(params.fasta)
        .map { f -> file(f) }

    seqkit_grep(input_ch, params.seqkitToSearch)
    seqtk_sample(seqkit_grep.out, params.sampleSize)

    publish:
    seqkit_grep = seqkit_grep.out
    seqtk_sample = seqtk_sample.out
}

output {
    seqkit_grep {
        path 'seqkit'
    }
    seqtk_sample {
        path 'seqkit'
    }
}

process seqkit_grep {

    input:
    path fasta
    val seqkitToSearch

    output:
    path "seqkit_${fasta}"

    script:
    """
    seqkit grep -r -n -i -p ${seqkitToSearch} ${fasta} | seqkit grep -r -n -p "\\[*\\]" > seqkit_${fasta}
    """
}

process seqtk_sample {

    input:
    path fasta
    val sampleSize

    output:
    path "${fasta.baseName}_${sampleSize}seq.fasta"

    script:
    """
    seqtk sample -s100 ${fasta} ${sampleSize} > ${fasta.baseName}_${sampleSize}seq.fasta
    """
}

