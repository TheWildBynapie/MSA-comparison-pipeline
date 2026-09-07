#!/bin/bash -ue
mkdir MSA_outputs/test_gapless
case prank in
    mafft)     test_gapless.fasta > test_gapless/mafft.fasta ;;
    muscle)   muscle -align test_gapless.fasta -output test_gapless/muscle.fasta  ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/kalign.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/t_coffee.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/probcons.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/clustalw.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/clustalo.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/amap.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/prank.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/prank.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/fsa.fasta ;;
esac
