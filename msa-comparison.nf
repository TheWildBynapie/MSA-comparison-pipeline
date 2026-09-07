#!/usr/bin/env nextflow
include { align } from './modules/aligners.nf'
include { rustyMetal } from './modules/rusty-metal.nf'
include { graphs } from './modules/graphing.nf'

/*
* Inputs: the .fasta files to be aligned, and have those alignments compared.
* Runs: the runs of the MSA tools to be executed per fasta file.*
*
* The parameter values here are examples. They are overridden by the config file.
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
        'muscle:muscle:-align', 
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

    //Each input fasta file becomes a tuple of (sample_id, fasta_path)
    input_ch = channel.fromList(params.inputs)
        .map { f -> tuple(file(f).simpleName, file(f)) }

    //Each run is a tuple of (run_id, tool, options)
    run_ch = channel.fromList(params.runs)
        .map { entry ->
           def (run_id, tool, options) = entry.split(':', 3)
           tuple(run_id, tool, options)
        }

    // cross product: every (run, sample_id / fasta) combination
    combos = run_ch.combine(input_ch)
        .map { run_id, tool, options, sample_id, fasta -> tuple(run_id, tool, options, sample_id, fasta) }

    //Align everything
    align(combos)

    //Regroup alignments by the fasta file/sample_id
    alignments_by_sample = align.out.alignment
        .groupTuple()          // → (sample_id, [fasta1, fasta2, ..., fastaN])  -- one emission PER input file

    //Run rusty-metal, and then graphing on each group of alignments
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
    }

    rustyMetal {
        path 'rusty-metal'
    }

    MDS {
        path 'MSA_graphs'
    }
    hierarchical {
        path 'MSA_graphs'
    }
}
