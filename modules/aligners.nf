// def getContainer(String toolName) {
//     def mapping = [
//         pagan: 'ariloytynoja/pagan2:latest',
//         pasta: 'smirarab/pasta:latest'
//     ]
//     return mapping[toolName]
// }

process align {
    // container { tool in ['pagan', 'pasta'] ? getContainer(tool) : null }

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
        prank)    prank -d=${sequences} -o=prank -shortnames ${options} && mv prank.best.fas ${sample_id}/${run_id}.fasta ;;
        fsa)      fsa ${options} ${sequences} > ${sample_id}/${run_id}.fasta ;;
        muscle3.8) muscle3.8 ${options} -in ${sequences} -out ${sample_id}/${run_id}.fasta ;;
        famsa)    famsa ${options} ${sequences} ${sample_id}/${run_id}.fasta ;;
        pagan)    pagan2 ${options} -q ${sequences} -o ${sample_id}/${run_id}.fasta ;;
        bali-phy)  bali-phy ${options} ${sequences}
            alignment-find < ${sequences.baseName}-1/C1.P1.fastas > temp.fasta
            awk '/^>A[0-9]+/ {skip=1; next} /^>/ {skip=0} !skip' temp.fasta > ${sample_id}/${run_id}.fasta;;
        magus)    magus -i ${sequences} -o ${sample_id}/${run_id}.fasta ${options};;
        pasta)    pasta ${options} -i ${sequences} -o ${sample_id}/${run_id}.fasta ;;
    esac
    sed -i 's/^>\\(.\\)/>\\U\\1/' ${sample_id}/${run_id}.fasta
    """
}