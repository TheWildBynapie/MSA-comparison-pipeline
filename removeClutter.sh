#!/bin/bash
#Removes the work, results, and .nextflow.log* files. These are nice to get rid of to clean the working directory.

rm -r results
rm -r work
rm .nextflow.log*