#!/bin/bash -ue
mkdir test_gapless
case prank in
    mafft)     test_gapless.fasta > test_gapless/prank.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/prank.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/prank.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/prank.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/prank.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/prank.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/prank.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/prank.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/prank.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/prank.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/prank.fasta ;;
esac
