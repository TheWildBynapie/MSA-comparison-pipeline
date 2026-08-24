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

// process t_coffee {
    
//     input:
//     val options
//     path sequences

//     output:
//     path 't_coffee.fasta'

//     script:
//     """
//     t_coffee ${sequences} > t_coffee.fasta
//     """
// }

process kalign {

    input:
    val options
    path sequences

    output:
    path 'kalign.fasta'

    script:
    """
    kalign ${options} -i ${sequences} -o kalign.fasta
    """
}