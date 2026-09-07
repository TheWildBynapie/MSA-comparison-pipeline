#!/bin/bash -ue
mkdir test_gapless
case fsa in
    mafft)     test_gapless.fasta > test_gapless/fsa.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/fsa.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/fsa.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/fsa.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/fsa.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/fsa.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/fsa.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/fsa.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/fsa.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/fsa.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/fsa.fasta ;;
esac
