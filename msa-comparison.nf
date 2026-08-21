#!/usr/bin/env nextflow

include { mafft } from './modules/aligners.nf'
include { muscle } from './modules/aligners.nf'
include { rustyMetal } from './modules/rusty-metal.nf'

/*
*
*/
params {
    input: Path = 'data/test.fasta'
    mafft_options: String = 'mafft --auto'
    muscle_options: String = ''
}

workflow {

    main:
    // emit a greeting
    mafft(params.mafft_options, params.input)
    muscle(params.muscle_options, params.input)

    alignments = mafft.out
        .mix(muscle.out)
        .collect()

    rustyMetal(alignments)

    publish:
    mafft = mafft.output
    muscle = muscle.output
    rustyMetal = rustyMetal.output
}

output {
    mafft {
        path 'MSA_outputs'
        mode 'copy'
    }
    muscle {
        path 'MSA_outputs'
        mode 'copy'
    }
    rustyMetal {
        path 'rusty-metal'
        mode 'copy'
    }
}
