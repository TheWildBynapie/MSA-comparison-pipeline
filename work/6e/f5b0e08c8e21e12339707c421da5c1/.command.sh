#!/bin/bash -ue
echo "Searching for Cytochrome c oxidase subunit I in sequence.fasta"
seqkit grep -r -n -i -p Cytochrome c oxidase subunit I sequence.fasta | seqkit grep -r -n -p "\[*\]" > seqkit_sequence.fasta
