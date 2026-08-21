process rustyMetal {

    input:
    val aligners

    output:
    path 'rusty-metal.csv'

    script:
    """
    rusty-metal ${aligners.join(' ')} -o rusty-metal.csv
    """
}