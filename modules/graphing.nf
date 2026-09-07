process graphs {
    tag "${sample_id}"

    input:
    path main_graphing_file
    tuple val (sample_id), path (distance_matrix_file)

    output:
    path "${sample_id}/MSA_distances.png", emit: MDS
    path "${sample_id}/MSA_hierarchical.png", emit: hierarchical

    script:
    """
    mkdir ${sample_id}
    python3 ${main_graphing_file} -i ${distance_matrix_file} -o ${sample_id}
    """
}