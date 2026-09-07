#!/bin/bash -ue
mkdir test_gapless
case clustalo in
    mafft)     test_gapless.fasta > test_gapless/clustalo.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/clustalo.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/clustalo.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/clustalo.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/clustalo.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/clustalo.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/clustalo.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/clustalo.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/clustalo.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/clustalo.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/clustalo.fasta ;;
esac
