# MSA-comparison-pipeline
A Nextflow pipeline which runs several MSA programs on the given input .fasta, compares their output using rusty-metal and then displays their relative distances


# Aligner details
| Name          | Version number | Latest version as of | Working | Notes |
| ------------- | -------------- | ------------------------- | - |----- |
| AMAP-align    |AMAP.2.2|30/08/2026|yes| |
| Clustal Omega |1.0.3|                           | yes | clustal.org hates me|
| ClustalW      |2.1|30/08/2026|yes|at least this is latest anyway lol|
| DIALIGN-TX    |                |                           |no|       |
| FSA           |1.15.9|                           |n/a|       |
| Kalign        |3.4.0|                           |yes|need 3.5.1 as of 30/08/2026|
| MAFFT         |v7.526|30/08/2026|yes| |
| MUSCLE        |5.3.linux64|30/08/2026|yes| |
| MUSTANG       |v3.2.4|                           |n/a| |
| POA           |                |                           |n/a| |
| PRANK         |v.250331|                           |yes| |
| ProbCons      |1.12|30/08/2026|yes| |
| PRODA         |1.0|                           |n/a| |
| T-Coffee      |Version_13.46.0.919e8c6b|                           |yes| |
| TM-align      |                |                           |no| |

