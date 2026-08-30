#!/usr/bin/env nextflow

include { mafft } from './modules/aligners.nf'
include { muscle } from './modules/aligners.nf'
include { kalign } from './modules/aligners.nf'

include { rustyMetal } from './modules/rusty-metal.nf'

include { MDS } from './modules/graphing.nf'

/*
*
*/
params {
    input: Path = 'data/test.fasta'
    mafft_options: String = 'mafft --auto'
    muscle_options: String = ''
    kalign_options: String = ''
}

workflow {

    main:
    mafft(params.mafft_options, params.input)
    muscle(params.muscle_options, params.input)
    kalign(params.kalign_options, params.input)

    alignments = mafft.out
        .mix(muscle.out)
        .mix(kalign.out)
        .collect()

    rustyMetal(alignments)

    MDS(file('non-nextflow/mds.py'),rustyMetal.out)

    publish:
    mafft = mafft.output
    muscle = muscle.output
    kalign = kalign.output
    rustyMetal = rustyMetal.output
    MDS = MDS.output
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
    kalign {
        path 'MSA_outputs'
        mode 'copy'
    }
    rustyMetal {
        path 'rusty-metal'
        mode 'copy'
    }
    MDS {
        path 'MSA_distances'
        mode 'copy'
    }
}
