#!/bin/bash
#./multipleRuns.sh

nextflow msa-comparison.nf -profile mammals
nextflow msa-comparison.nf -profile animals
nextflow msa-comparison.nf -profile eukaryotes
nextflow msa-comparison.nf -profile bacteria
nextflow msa-comparison.nf -profile viruses