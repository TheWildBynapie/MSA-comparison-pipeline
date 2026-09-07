process align {
    tag "${sample_id}:${tool}"

    input:
    tuple val(sample_id), val(tool), val(options), path(sequences)

    output:
    tuple val(sample_id), val(tool), path("${sample_id}/${tool}.fasta"), emit: alignment

    script:
    """
    mkdir ${sample_id}
    case ${tool} in
        mafft)    ${options} ${sequences} > ${sample_id}/mafft.fasta ;;
        muscle)   muscle -align ${sequences} -output ${sample_id}/muscle.fasta ${options} ;;
        kalign)   kalign ${options} -i ${sequences} -o ${sample_id}/kalign.fasta ;;
        t_coffee) t_coffee ${sequences} -output=fasta -outfile=${sample_id}/t_coffee.fasta ${options} ;;
        probcons) probcons ${options} ${sequences} > ${sample_id}/probcons.fasta ;;
        clustalw) clustalw ${sequences} -output=fasta -outfile=${sample_id}/clustalw.fasta ${options} ;;
        clustalo) clustalo -i ${sequences} -o ${sample_id}/clustalo.fasta ${options} ;;
        amap)     amap ${options} ${sequences} > ${sample_id}/amap.fasta ;;
        prank)    prank -d=${sequences} -o=prank ${options} && mv prank.best.fas ${sample_id}/prank.fasta && sed -i '/^>/ s/.*/\\L&/' ${sample_id}/prank.fasta ;;
        fsa)      fsa ${options} ${sequences} > ${sample_id}/fsa.fasta ;;
    esac
    """
}