#!/usr/bin/env nextflow

include { mafft } from './modules/aligners.nf'
include { muscle } from './modules/aligners.nf'
include { kalign } from './modules/aligners.nf'
include { t_coffee } from './modules/aligners.nf'
include { probcons } from './modules/aligners.nf'
include { clustalw } from './modules/aligners.nf'
include { clustalo } from './modules/aligners.nf'
include { amap } from './modules/aligners.nf'

include { rustyMetal } from './modules/rusty-metal.nf'

include { graphs } from './modules/graphing.nf'

/*
*
*/
params {
    input: Path = 'data/test_gapless.fasta'
    mafft_options: String = 'mafft --auto'
    muscle_options: String = ''
    kalign_options: String = ''
    t_coffee_options: String = ''
    probcons_options: String = ''
    clustalw_options: String = ''
    clustalo_options: String = ''
    amap_options: String = ''

}

workflow {

    main:
    mafft(params.mafft_options, params.input)
    muscle(params.muscle_options, params.input)
    kalign(params.kalign_options, params.input)
    t_coffee(params.t_coffee_options, params.input)
    probcons(params.probcons_options, params.input)
    clustalw(params.clustalw_options, params.input)
    clustalo(params.clustalo_options, params.input)
    amap(params.amap_options, params.input)

    alignments = mafft.out
        .mix(muscle.out)
        .mix(kalign.out)
        .mix(t_coffee.out.MSA)
        .mix(probcons.out)
        .mix(clustalw.out)
        .mix(clustalo.out)
        .mix(amap.out)
        .collect()

    rustyMetal(alignments)

    graphs(file('non-nextflow/make_distance_matrix.py'),rustyMetal.out)

    publish:
    mafft = mafft.output
    muscle = muscle.output
    kalign = kalign.output
    t_coffee = t_coffee.output.MSA
    probcons = probcons.out
    clustalw = clustalw.output
    clustalo = clustalo.output
    amap = amap.output

    rustyMetal = rustyMetal.output

    MDS = graphs.out.MDS
    hierarchical = graphs.out.hierarchical
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
    t_coffee{
        path 'MSA_outputs'
        mode 'copy'
    }
    probcons {
        path 'MSA_outputs'
        mode 'copy'
    }
    clustalw {
        path 'MSA_outputs'
        mode 'copy'
    }
    clustalo {
        path 'MSA_outputs'
        mode 'copy'
    }
    amap {
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
