#!/bin/bash -ue
mkdir test
case probcons in
    mafft)     test.fasta > test/probcons.fasta ;;
    muscle)   muscle  test.fasta -output test/probcons.fasta ;;
    kalign)   kalign  -i test.fasta -o test/probcons.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/probcons.fasta  ;;
    probcons) probcons  test.fasta > test/probcons.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/probcons.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/probcons.fasta  ;;
    amap)     amap  test.fasta > test/probcons.fasta ;;
    prank)    prank -d=test.fasta -o=prank -shortnames  && mv prank.best.fas test/probcons.fasta ;;
    fsa)      fsa  test.fasta > test/probcons.fasta ;;
esac
sed -i 's/^>\(.\)/>\U\1/' test/probcons.fasta
