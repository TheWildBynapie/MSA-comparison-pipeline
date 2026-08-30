process MDS {
    input:
    path mds_dot_py
    path distance_matrix_file

    output:
    path "MSA_distances.png"

    script:
    """
    python3 ${mds_dot_py} -i ${distance_matrix_file}
    """
}