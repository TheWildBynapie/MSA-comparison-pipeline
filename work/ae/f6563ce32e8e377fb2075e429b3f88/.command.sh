#!/bin/bash -ue
mkdir test_gapless
case muscle in
    mafft)    -align test_gapless.fasta > test_gapless/muscle.fasta ;;
    muscle)   muscle -align test_gapless.fasta -output test_gapless/muscle.fasta ;;
    kalign)   kalign -align -i test_gapless.fasta -o test_gapless/muscle.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/muscle.fasta -align ;;
    probcons) probcons -align test_gapless.fasta > test_gapless/muscle.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/muscle.fasta -align ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/muscle.fasta -align ;;
    amap)     amap -align test_gapless.fasta > test_gapless/muscle.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank -align && mv prank.best.fas test_gapless/muscle.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/muscle.fasta ;;
    fsa)      fsa -align test_gapless.fasta > test_gapless/muscle.fasta ;;
esac
