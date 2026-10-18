#!/bin/bash
#./multipleRuns.sh

#nextflow msa-comparison.nf -profile blasthuman
#nextflow msa-comparison.nf -profile blastlamprey
#nextflow msa-comparison.nf -profile blastoctopus
nextflow msa-comparison.nf -profile blastrice
nextflow msa-comparison.nf -profile blastcorgl