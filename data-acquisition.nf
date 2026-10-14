#!/usr/bin/env nextflow
//e.g:
//nextflow data-acquisition.nf -c dataac.config 


/*You need to specify what seqkit must look for in the headers
* default seqtk sample size is 50
* 
* Don't forget to override the default config file: -c "dataac.config"
*/
params {
    sources: List<String> = ['data/raw/sequence.fasta:Seq']
    sampleSize: Integer = 50
}

workflow {
    main:

    input_ch = channel.fromList(params.sources)
        .map { entry ->
            def (path, searchTerm) = entry.split(':', 2)
            tuple(file(path), searchTerm)
        }.view()

    seqkit_grep(input_ch)
    seqtk_sample(seqkit_grep.out, params.sampleSize)

    publish:
    //seqkit_grep = seqkit_grep.out
    seqtk_sample = seqtk_sample.out
}

output {
    // seqkit_grep {
    //     path 'seqkit'
    // }
    seqtk_sample {
        path 'seqkit'
    }
}

process seqkit_grep {

    input:
    tuple path(fasta), val(seqkitToSearch)

    output:
    path "${fasta}-pruned"

    script:
    if (fasta.name.contains("SwissProt"))
        """
        seqkit grep -r -n -i -p "${seqkitToSearch}" "${fasta}" > "${fasta}-pruned"
        """
    else
        """
        seqkit grep -r -n -i -p "${seqkitToSearch}" "${fasta}" | seqkit grep -r -n -p "\\[*\\]" > "${fasta}-pruned"
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

