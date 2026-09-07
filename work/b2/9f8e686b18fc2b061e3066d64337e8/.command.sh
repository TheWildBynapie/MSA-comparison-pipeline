#!/bin/bash -ue
mkdir test
case muscle in
    mafft)    -align test.fasta > test/muscle.fasta ;;
    muscle)   muscle -align test.fasta -output test/muscle.fasta ;;
    kalign)   kalign -align -i test.fasta -o test/muscle.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/muscle.fasta -align ;;
    probcons) probcons -align test.fasta > test/muscle.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/muscle.fasta -align ;;
    clustalo) clustalo -i test.fasta -o test/muscle.fasta -align ;;
    amap)     amap -align test.fasta > test/muscle.fasta ;;
    prank)    prank -d=test.fasta -o=prank -align && mv prank.best.fas test/muscle.fasta && sed -i '/^>/ s/.*/\L&/' test/muscle.fasta ;;
    fsa)      fsa -align test.fasta > test/muscle.fasta ;;
esac
