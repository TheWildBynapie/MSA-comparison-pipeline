# Data Acquisition
This doc contains explanations for how I acquired the data I used in testing the pipeline.

## NCBI protein data

| protein class name| Procedure | ncbi search | seqkit command | Notes |
| ------------------------ | --- | ------------------------------------ | ------------------------- | ------------------------ |
|Mammal Histone H3| 1 | | ```seqkit grep -r -n -i -p "histone h3" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Mammal Growth Hormone| 1 | | ```seqkit grep -r -n -i -p "growth hormone" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Mammal MHC| 1 | | ```seqkit grep -r -n -i -p "MHC" -p "major histocompatibility complex" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Animal Cytochrome c oxidase subunit I| 1 | | ```seqkit grep -r -n -i -p "Cytochrome c oxidase subunit I" input.fasta \| seqkit grep -r -n -p "\[*\]" > output.fasta``` | |
|Animal Histone H3 | 1 | (Histone H3) AND "animals"[porgn:__txid33208] AND srcdb_refseq[Properties] | | |
|Eukaryotic Histone H4 | 1 | (Histone h4) AND "eukaryotes"[porgn:__txid2759] | | |
|Eukaryotic p53 | 1 | (p53) AND "eukaryotes"[porgn:__txid2759] | | |
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

## BLASTp data

| protein class name| Procedure | ncbi search | seqkit command | Notes |
| ------------------------ | --- | ------------------------------------ | ------------------------- | ------------------------ |

### Procedure 2: UniProtKB and BLASTp 
1. Go to [UniProtKB](https://www.uniprot.org/)
2. Search for the chosen gene, e.g `human p53`
3. Filter by Swiss-prot
4. Select the first option (given its reasonable) here `P04637`, `P53_HUMAN`, `gene: TP53`
5. Click 'sequence and isoforms' on the left, and copy the sequence
6. Go to [BLASTp](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE=Proteins)
7. Enter the sequence,
   database: clustered_nr,
   algorithm parameters: Max target sequences: 5000
