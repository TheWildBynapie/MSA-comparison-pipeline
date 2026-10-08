#!/bin/bash -ue
mkdir test
case clustalo in
    mafft)     test.fasta > test/clustalo.fasta ;;
    muscle)   muscle  test.fasta -output test/clustalo.fasta ;;
    kalign)   kalign  -i test.fasta -o test/clustalo.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/clustalo.fasta  ;;
    probcons) probcons  test.fasta > test/clustalo.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/clustalo.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/clustalo.fasta  ;;
    amap)     amap  test.fasta > test/clustalo.fasta ;;
    prank)    prank -d=test.fasta -o=prank -shortnames  && mv prank.best.fas test/clustalo.fasta ;;
    fsa)      fsa  test.fasta > test/clustalo.fasta ;;
esac
sed -i 's/^>\(.\)/>\U\1/' test/clustalo.fasta
