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

process t_coffee {
    
    input:
    val options
    path sequences

    output:
    path 't_coffee.fasta', emit: MSA

    script:
    """
    t_coffee ${sequences} -output=fasta -outfile=t_coffee.fasta ${options}
    """
}

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

process probcons {
    input:
    val options
    path sequences

    output:
    path 'probcons.fasta'

    script:
    """
    probcons ${options} ${sequences} > probcons.fasta
    """
}

process clustalw {
    input:
    val options
    path sequences

    output:
    path 'clustalw.fasta'

    script:
    """
    clustalw ${sequences} -output=fasta -outfile=clustalw.fasta ${options}
    """
}

process clustalo {
    input:
    val options
    path sequences

    output:
    path 'clustalo.fasta'

    script:
    """
    clustalo -i ${sequences} -o clustalo.fasta ${options}
    """
}

process amap {
    input:
    val options
    path sequences

    output:
    path 'amap.fasta'

    script:
    """
    amap ${options} ${sequences} > amap.fasta
    """
}

// process dialign_tx {
//     input:
//     val options
//     path sequences

//     output:
//     path 'dialign-tx.fasta'

//     script:
//     """
//     dialign-tx ${options} ${sequences} dialign-tx.fasta
//     """
// }