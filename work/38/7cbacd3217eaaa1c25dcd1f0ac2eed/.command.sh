#!/bin/bash -ue
mkdir test_gapless
case amap in
    mafft)     test_gapless.fasta > test_gapless/amap.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/amap.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/amap.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/amap.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/amap.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/amap.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/amap.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/amap.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/amap.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/amap.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/amap.fasta ;;
esac
