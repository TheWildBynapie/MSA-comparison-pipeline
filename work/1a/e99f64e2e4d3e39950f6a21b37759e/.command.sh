#!/bin/bash -ue
mkdir test
case clustalw in
    mafft)     test.fasta > test/clustalw.fasta ;;
    muscle)   muscle  test.fasta -output test/clustalw.fasta ;;
    kalign)   kalign  -i test.fasta -o test/clustalw.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/clustalw.fasta  ;;
    probcons) probcons  test.fasta > test/clustalw.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/clustalw.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/clustalw.fasta  ;;
    amap)     amap  test.fasta > test/clustalw.fasta ;;
    prank)    prank -d=test.fasta -o=prank -shortnames  && mv prank.best.fas test/clustalw.fasta ;;
    fsa)      fsa  test.fasta > test/clustalw.fasta ;;
esac
sed -i 's/^>\(.\)/>\U\1/' test/clustalw.fasta
