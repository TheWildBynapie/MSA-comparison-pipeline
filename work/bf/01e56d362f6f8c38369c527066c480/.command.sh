#!/bin/bash -ue
mkdir test_gapless
case probcons in
    mafft)     test_gapless.fasta > test_gapless/probcons.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/probcons.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/probcons.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/probcons.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/probcons.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/probcons.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/probcons.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/probcons.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/probcons.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/probcons.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/probcons.fasta ;;
esac
