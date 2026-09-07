#!/bin/bash -ue
mkdir test
case kalign in
    mafft)     test.fasta > test/kalign.fasta ;;
    muscle)   muscle  test.fasta -output test/kalign.fasta ;;
    kalign)   kalign  -i test.fasta -o test/kalign.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/kalign.fasta  ;;
    probcons) probcons  test.fasta > test/kalign.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/kalign.fasta  ;;
    clustalo) clustalo -i test.fasta -o test/kalign.fasta  ;;
    amap)     amap  test.fasta > test/kalign.fasta ;;
    prank)    prank -d=test.fasta -o=prank  && mv prank.best.fas test/kalign.fasta && sed -i '/^>/ s/.*/\L&/' test/kalign.fasta ;;
    fsa)      fsa  test.fasta > test/kalign.fasta ;;
esac
