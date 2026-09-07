process rustyMetal {
    tag "${sample_id}"

    input:
    tuple val(sample_id), path(alignments)

    output:
    tuple val(sample_id), path("rusty_metal_${sample_id}.csv"), emit: output

    script:
    """
    rusty-metal ${alignments.join(' ')} -o rusty_metal_${sample_id}.csv
    """
}