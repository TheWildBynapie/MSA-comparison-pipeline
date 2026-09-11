#!/bin/bash -ue
seqkit grep -r -n -i -p "Cytochrome c oxidase subunit I" sequence.fasta | seqkit grep -r -n -p "\[*\]" > sequence.fasta
