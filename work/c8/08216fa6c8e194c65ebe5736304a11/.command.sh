#!/bin/bash -ue
mkdir test_gapless
case t_coffee in
    mafft)     test_gapless.fasta > test_gapless/t_coffee.fasta ;;
    muscle)   muscle  test_gapless.fasta -output test_gapless/t_coffee.fasta ;;
    kalign)   kalign  -i test_gapless.fasta -o test_gapless/t_coffee.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/t_coffee.fasta  ;;
    probcons) probcons  test_gapless.fasta > test_gapless/t_coffee.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/t_coffee.fasta  ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/t_coffee.fasta  ;;
    amap)     amap  test_gapless.fasta > test_gapless/t_coffee.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank  && mv prank.best.fas test_gapless/t_coffee.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/t_coffee.fasta ;;
    fsa)      fsa  test_gapless.fasta > test_gapless/t_coffee.fasta ;;
esac
