#!/bin/bash -ue
mkdir test_gapless
case mafft in
    mafft)    linsi test_gapless.fasta > test_gapless/mafft_linsi.fasta ;;
    muscle)   muscle linsi test_gapless.fasta -output test_gapless/mafft_linsi.fasta ;;
    kalign)   kalign linsi -i test_gapless.fasta -o test_gapless/mafft_linsi.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/mafft_linsi.fasta linsi ;;
    probcons) probcons linsi test_gapless.fasta > test_gapless/mafft_linsi.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/mafft_linsi.fasta linsi ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/mafft_linsi.fasta linsi ;;
    amap)     amap linsi test_gapless.fasta > test_gapless/mafft_linsi.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank linsi && mv prank.best.fas test_gapless/mafft_linsi.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/mafft_linsi.fasta ;;
    fsa)      fsa linsi test_gapless.fasta > test_gapless/mafft_linsi.fasta ;;
esac
