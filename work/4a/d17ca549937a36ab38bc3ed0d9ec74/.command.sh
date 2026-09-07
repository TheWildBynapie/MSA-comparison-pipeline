#!/bin/bash -ue
mkdir test_gapless
case mafft in
    mafft)    mafft --auto test_gapless.fasta > test_gapless/mafft_auto.fasta ;;
    muscle)   muscle mafft --auto test_gapless.fasta -output test_gapless/mafft_auto.fasta ;;
    kalign)   kalign mafft --auto -i test_gapless.fasta -o test_gapless/mafft_auto.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/mafft_auto.fasta mafft --auto ;;
    probcons) probcons mafft --auto test_gapless.fasta > test_gapless/mafft_auto.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/mafft_auto.fasta mafft --auto ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/mafft_auto.fasta mafft --auto ;;
    amap)     amap mafft --auto test_gapless.fasta > test_gapless/mafft_auto.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank mafft --auto && mv prank.best.fas test_gapless/mafft_auto.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/mafft_auto.fasta ;;
    fsa)      fsa mafft --auto test_gapless.fasta > test_gapless/mafft_auto.fasta ;;
esac
