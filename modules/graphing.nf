process graphs {
    input:
    path main_graphing_file
    path distance_matrix_file

    output:
    path "MSA_distances.png", emit: MDS
    path "MSA_hierarchical.png", emit: hierarchical

    script:
    """
    python3 ${main_graphing_file} -i ${distance_matrix_file}
    """
}