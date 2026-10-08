#!/bin/bash -ue
mkdir test
case fsa in
    mafft)     test.fasta > test/fsa.fasta ;;
    muscle)   muscle  test.fasta -output test/fsa.fasta ;;
    kalign)   kalign  -i test.fasta -o test/fsa.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/fsa.fasta  ;;
    probcons) probcons  test.fasta > test/fsa.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/fsa.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/fsa.fasta  ;;
    amap)     amap  test.fasta > test/fsa.fasta ;;
    prank)    prank -d=test.fasta -o=prank -shortnames  && mv prank.best.fas test/fsa.fasta ;;
    fsa)      fsa  test.fasta > test/fsa.fasta ;;
esac
sed -i 's/^>\(.\)/>\U\1/' test/fsa.fasta
