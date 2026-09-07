#!/usr/bin/env nextflow
include { align } from './modules/aligners.nf'
include { rustyMetal } from './modules/rusty-metal.nf'
include { graphs } from './modules/graphing.nf'

/*
*
*/
params {
    inputs: List<String> = ['data/test_gapless.fasta']
    runs: List<String> = [
        /*Each line defines a run of a MSA tool.
        * Run names are arbitrary, but must be unique. They are used in the output file names.
        * The format is:
        * '<run name>:<tool name>:<tool_options>'
        */
        'mafft_auto:mafft:mafft --auto', 
        'mafft_linsi:mafft:linsi',
        'muscle:muscle:', 
        'kalign:kalign:', 
        't_coffee:t_coffee:', 
        'probcons:probcons:', 
        'clustalw:clustalw:', 
        'clustalo:clustalo:', 
        'amap:amap:', 
        'prank:prank:', 
        'fsa:fsa:'
    ]
}

workflow {
    main:

    input_ch = channel.fromList(params.inputs)
        .map { f -> tuple(file(f).simpleName, file(f)) }   // (sample_id, fasta)

    run_ch = channel.fromList(params.runs)
        .map { entry ->
           def (run_id, tool, options) = entry.split(':', 3)
           tuple(run_id, tool, options)
        }

    // cross product: every (run, sample_id / fasta) combination
    combos = run_ch.combine(input_ch)
        .map { run_id, tool, options, sample_id, fasta -> tuple(run_id, tool, options, sample_id, fasta) }

    align(combos)

    alignments_by_sample = align.out.alignment
        //.map { sample_id, fasta -> tuple(sample_id, fasta) }
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
