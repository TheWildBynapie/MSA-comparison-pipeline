#!/bin/bash -ue
mkdir test_gapless
case kalign in
    mafft)     test_gapless.fasta > test_gapless/kalign.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/kalign.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/kalign.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/kalign.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/kalign.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/kalign.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/kalign.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/kalign.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/kalign.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/kalign.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/kalign.fasta ;;
esac
