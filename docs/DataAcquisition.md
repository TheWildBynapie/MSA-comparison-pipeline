# Data Acquisition
This doc contains explanations for how I acquired the data I used in testing the pipeline.

## NCBI protein data

| protein class name| Procedure | ncbi search | seqkit command | Notes |
| ------------------------ | --- | ------------------------------------ | ------------------------- | ------------------------ |
|Mammal Histone H3| 1 | | ```seqkit grep -r -n -i -p "histone h3" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Mammal Growth Hormone| 1 | | ```seqkit grep -r -n -i -p "growth hormone" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Mammal MHC| 1 | | ```seqkit grep -r -n -i -p "MHC" -p "major histocompatibility complex" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Animal Cytochrome c oxidase subunit I| 1 | | ```seqkit grep -r -n -i -p "Cytochrome c oxidase subunit I" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
| | 1 | (Histone H3) AND "animals"[porgn:__txid33208] AND srcdb_refseq[Properties] | | |
| | 1 | (Histone h4) AND "eukaryotes"[porgn:__txid2759] | | |
| | 1 | (p53) AND "eukaryotes"[porgn:__txid2759] | | |
| | 1 | (RpoB) AND "bacteria"[porgn:__txid2] AND srcdb_refseq[properties] | | |
| | 1 | (beta lactamase) AND "bacteria"[porgn:__txid2] AND srcdb_swiss-prot[properties] | | |
| | 1 | (RdRp) AND "viruses"[porgn:__txid10239] AND srcdb_refseq[properties] | | |
| | 1 | ((Influenza Hemagglutinin) AND "viruses"[porgn:__txid10239]) AND "viruses"[porgn:__txid10239] | | |
| | 1 | HIV env AND srcdb_refseq[properties] | | |


### procedure 1: ncbi data 11/09
1. Search in NCBI protein database: `(histone h3) AND "mammals"[porgn:__txid40674]`
2. Send to > File > Format:FASTA, Order: By organism name
3. Get only the Histone H3 proteins (replace filenames accordingly): 
```bash
seqkit grep -r -n -i -p "histone h3" input.fasta | seqkit grep -r -n -p "\[*\]" > output.fasta #This line is replaced for each dataset
```
4. Take a n=50 subsample (replace filenames accordingly)
```bash
seqtk sample -s100 output.fasta 50 > subset.fasta
```

### blastSeqtk.fasta 11/09
1. Search in blastp for:

`MARTKQTARKSTGGKAPRKQLATKAARKSAPATGGVKKPHRYRPGTVALREIRRYQKSTELLIRKLPFQRLVREIAQDFKTDLRFQSSAVMALQEACEAYLVGLFEDTNLCAIHAKRVTIMPKDIQLARRIRGERA`

2. Show 100 results and download them
3. Take a n=20 subsample (replace filenames accordingly)
```bash
seqtk sample -s100 all_hits.fasta 20 > subset.fasta
```

### 