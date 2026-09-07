#!/usr/bin/env nextflow
include { align } from './modules/aligners.nf'
include { rustyMetal } from './modules/rusty-metal.nf'
include { graphs } from './modules/graphing.nf'

/*
*
*/
params {
    inputs: List<String> = ['data/test_gapless.fasta']
    aligners: List<String> = ['mafft', 'muscle', 'kalign', 't_coffee', 'probcons', 'clustalw', 'clustalo', 'amap', 'prank', 'fsa']
    mafft_options: String = 'mafft --auto'
    muscle_options: String = ''
    kalign_options: String = ''
    t_coffee_options: String = ''
    probcons_options: String = ''
    clustalw_options: String = ''
    clustalo_options: String = ''
    amap_options: String = ''
    prank_options: String = ''
    fsa_options: String = ''
}

workflow {
    main:
    def optionsMap = [
        mafft: params.mafft_options, muscle: params.muscle_options,
        kalign: params.kalign_options, t_coffee: params.t_coffee_options,
        probcons: params.probcons_options, clustalw: params.clustalw_options,
        clustalo: params.clustalo_options, amap: params.amap_options,
        prank: params.prank_options, fsa: params.fsa_options,
    ]

    input_ch = channel.fromList(params.inputs)
        .map { f -> tuple(file(f).simpleName, file(f)) }   // (sample_id, fasta)

    tool_ch = channel.fromList(params.aligners)

    // cross product: every (tool, sample_id, fasta) combination
    combos = tool_ch.combine(input_ch)
        .map { tool, sample_id, fasta -> tuple(sample_id, tool, optionsMap[tool], fasta) }

    align(combos)

    alignments_by_sample = align.out.alignment
        .map { sample_id, tool, fasta -> tuple(sample_id, fasta) }
        .groupTuple()          // → (sample_id, [fasta1, fasta2, ..., fastaN])  -- one emission PER input file

    rustyMetal(alignments_by_sample)

    graphs(file('non-nextflow/make_distance_matrix.py'),rustyMetal.out)

    publish:
    aligners     = align.out.alignment
    rustyMetal   = rustyMetal.output
    MDS          = graphs.out.MDS
    hierarchical = graphs.out.hierarchical
}

output {
    aligners {
        path 'MSA_outputs'
        mode 'copy'
    }

    rustyMetal {
        path 'rusty-metal'
        mode 'copy'
    }

    MDS {
        path 'MSA_graphs'
        mode 'copy'
    }
    hierarchical {
        path 'MSA_graphs'
        mode 'copy'
    }
}
