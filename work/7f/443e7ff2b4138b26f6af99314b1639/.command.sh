#!/bin/bash -ue
mkdir test_gapless
case mafft in
    mafft)    mafft --auto test_gapless.fasta > test_gapless/mafft.fasta ;;
    muscle)   muscle -align test_gapless.fasta -output test_gapless/muscle.fasta mafft --auto ;;
    kalign)   kalign mafft --auto -i test_gapless.fasta -o test_gapless/kalign.fasta ;;
    t_coffee) t_coffee test_gapless.fasta -output=fasta -outfile=test_gapless/t_coffee.fasta mafft --auto ;;
    probcons) probcons mafft --auto test_gapless.fasta > test_gapless/probcons.fasta ;;
    clustalw) clustalw test_gapless.fasta -output=fasta -outfile=test_gapless/clustalw.fasta mafft --auto ;;
    clustalo) clustalo -i test_gapless.fasta -o test_gapless/clustalo.fasta mafft --auto ;;
    amap)     amap mafft --auto test_gapless.fasta > test_gapless/amap.fasta ;;
    prank)    prank -d=test_gapless.fasta -o=prank mafft --auto && mv prank.best.fas test_gapless/prank.fasta && sed -i '/^>/ s/.*/\L&/' test_gapless/prank.fasta ;;
    fsa)      fsa mafft --auto test_gapless.fasta > test_gapless/fsa.fasta ;;
esac
