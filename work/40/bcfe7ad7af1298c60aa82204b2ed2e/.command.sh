#!/bin/bash -ue
mkdir test
case mafft in
    mafft)    mafft --auto test.fasta > test/mafft_auto.fasta ;;
    muscle)   muscle mafft --auto test.fasta -output test/mafft_auto.fasta ;;
    kalign)   kalign mafft --auto -i test.fasta -o test/mafft_auto.fasta ;;
    t_coffee) t_coffee test.fasta -output=fasta -outfile=test/mafft_auto.fasta mafft --auto ;;
    probcons) probcons mafft --auto test.fasta > test/mafft_auto.fasta ;;
    clustalw) clustalw test.fasta -output=fasta -outfile=test/mafft_auto.fasta mafft --auto ;;
    clustalo) clustalo -i test.fasta -o test/mafft_auto.fasta mafft --auto ;;
    amap)     amap mafft --auto test.fasta > test/mafft_auto.fasta ;;
    prank)    prank -d=test.fasta -o=prank mafft --auto && mv prank.best.fas test/mafft_auto.fasta && sed -i '/^>/ s/.*/\L&/' test/mafft_auto.fasta ;;
    fsa)      fsa mafft --auto test.fasta > test/mafft_auto.fasta ;;
esac
