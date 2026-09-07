#!/bin/bash -ue
mkdir test
case mafft in
    mafft)    linsi test.fasta > test/mafft_linsi.fasta ;;
    muscle)   muscle linsi test.fasta -output test/mafft_linsi.fasta ;;
    kalign)   kalign linsi -i test.fasta -o test/mafft_linsi.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/mafft_linsi.fasta linsi ;;
    probcons) probcons linsi test.fasta > test/mafft_linsi.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/mafft_linsi.fasta linsi ;;
    clustalo) clustalo -i test.fasta -o test/mafft_linsi.fasta linsi ;;
    amap)     amap linsi test.fasta > test/mafft_linsi.fasta ;;
    prank)    prank -d=test.fasta -o=prank linsi && mv prank.best.fas test/mafft_linsi.fasta && sed -i '/^>/ s/.*/\L&/' test/mafft_linsi.fasta ;;
    fsa)      fsa linsi test.fasta > test/mafft_linsi.fasta ;;
esac
