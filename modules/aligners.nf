process mafft {

    input:
    val options
    path sequences

    output:
    path "mafft.fasta"

    script:
    """
    ${options} ${sequences} > mafft.fasta
    """
}

process muscle {

    input:
    val options
    path sequences

    output:
    path 'muscle.fasta'

    script:
    """
    muscle -align ${sequences} -output muscle.fasta ${options}
    """
}