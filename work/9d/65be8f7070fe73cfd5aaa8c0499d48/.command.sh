#!/bin/bash -ue
mkdir test_gapless
case clustalw in
    mafft)     test_gapless.fasta > test_gapless/clustalw.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/clustalw.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/clustalw.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/clustalw.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/clustalw.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/clustalw.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/clustalw.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/clustalw.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/clustalw.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/clustalw.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/clustalw.fasta ;;
esac
