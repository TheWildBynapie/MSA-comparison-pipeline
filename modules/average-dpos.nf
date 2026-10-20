process average_dpos {
    tag "average"

    input:
    path main_averaging_file
    path csvs

    output:
    tuple val("average-${workflow.profile}"), path("rusty-metal-average.csv"), emit: output

    script:
    """
    python3 ${main_averaging_file} -i ${csvs} -o rusty-metal-average.csv
    """
}