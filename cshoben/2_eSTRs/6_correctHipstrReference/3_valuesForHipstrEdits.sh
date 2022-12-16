#!/bin/bash

## $1 is the simplified repeat. 
## $2 is the expanded repeat. 

grep -w "$1" collapseHg19.hipstr_reference.txt
grep -w "$1" totalEstrStudied.txt
grep -w "$2" totalEstrStudied.txt
