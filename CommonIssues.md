# Common Issues while using the pipeline

### The way prank outputs sequence headers 
Likely errors:
* ValueError: Input X contains NaN
  "MDS does not accept missing values encoded as NaN natively..."
* Workflow doesn't run with a reference alignment included

Explanation:

1. Prank capitalizes the 1st letter of every sequence header. 
2. This means when rusty-metal compares sequences it won't see the prankMSA and otherMSA, or reference file sequence names as being the same sequence. 
3. This will create a NaN, and break MDS.
