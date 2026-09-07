process align {
    tag "${run_id}:${sample_id}:${tool}"

    input:
    tuple val(run_id), val(tool), val(options), val(sample_id),path(sequences)

    output:
    tuple val(sample_id), path("${sample_id}/${run_id}.fasta"), emit: alignment

    script:
    """
    mkdir ${sample_id}
    case ${tool} in
        mafft)    ${options} ${sequences} > ${sample_id}/${run_id}.fasta ;;
        muscle)   muscle ${options} ${sequences} -output ${sample_id}/${run_id}.fasta ;;
        kalign)   kalign ${options} -i ${sequences} -o ${sample_id}/${run_id}.fasta ;;
        t_coffee) t_coffee ${sequences} -output=fasta -outfile=${sample_id}/${run_id}.fasta ${options} ;;
        probcons) probcons ${options} ${sequences} > ${sample_id}/${run_id}.fasta ;;
        clustalw) clustalw ${sequences} -output=fasta -outfile=${sample_id}/${run_id}.fasta ${options} ;;
        clustalo) clustalo -i ${sequences} -o ${sample_id}/${run_id}.fasta ${options} ;;
        amap)     amap ${options} ${sequences} > ${sample_id}/${run_id}.fasta ;;
        prank)    prank -d=${sequences} -o=prank ${options} && mv prank.best.fas ${sample_id}/${run_id}.fasta && sed -i '/^>/ s/.*/\\L&/' ${sample_id}/${run_id}.fasta ;;
        fsa)      fsa ${options} ${sequences} > ${sample_id}/${run_id}.fasta ;;
    esac
    """
}