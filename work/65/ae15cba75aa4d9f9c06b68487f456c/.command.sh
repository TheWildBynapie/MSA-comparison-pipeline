#!/bin/bash -ue
mkdir test
case t_coffee in
    mafft)     test.fasta > test/t_coffee.fasta ;;
    muscle)   muscle  test.fasta -output test/t_coffee.fasta ;;
    kalign)   kalign  -i test.fasta -o test/t_coffee.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/t_coffee.fasta  ;;
    probcons) probcons  test.fasta > test/t_coffee.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/t_coffee.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/t_coffee.fasta  ;;
    amap)     amap  test.fasta > test/t_coffee.fasta ;;
    prank)    prank -d=test.fasta -o=prank  && mv prank.best.fas test/t_coffee.fasta && sed -i '/^>/ s/.*/\L&/' test/t_coffee.fasta ;;
    fsa)      fsa  test.fasta > test/t_coffee.fasta ;;
esac
