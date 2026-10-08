#!/bin/bash -ue
mkdir test
case prank in
    mafft)     test.fasta > test/prank.fasta ;;
    muscle)   muscle  test.fasta -output test/prank.fasta ;;
    kalign)   kalign  -i test.fasta -o test/prank.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/prank.fasta  ;;
    probcons) probcons  test.fasta > test/prank.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/prank.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/prank.fasta  ;;
    amap)     amap  test.fasta > test/prank.fasta ;;
    prank)    prank -d=test.fasta -o=prank -shortnames  && mv prank.best.fas test/prank.fasta ;;
    fsa)      fsa  test.fasta > test/prank.fasta ;;
esac
sed -i 's/^>\(.\)/>\U\1/' test/prank.fasta
