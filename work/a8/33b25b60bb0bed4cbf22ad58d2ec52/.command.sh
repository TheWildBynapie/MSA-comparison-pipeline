#!/bin/bash -ue
mkdir test
case amap in
    mafft)     test.fasta > test/amap.fasta ;;
    muscle)   muscle  test.fasta -output test/amap.fasta ;;
    kalign)   kalign  -i test.fasta -o test/amap.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/amap.fasta  ;;
    probcons) probcons  test.fasta > test/amap.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/amap.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/amap.fasta  ;;
    amap)     amap  test.fasta > test/amap.fasta ;;
    prank)    prank -d=test.fasta -o=prank -shortnames  && mv prank.best.fas test/amap.fasta ;;
    fsa)      fsa  test.fasta > test/amap.fasta ;;
esac
sed -i 's/^>\(.\)/>\U\1/' test/amap.fasta
