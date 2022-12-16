#!/bin/bash

## $1 will be the path to the tissue_master.tab for example /hpc/group/vertgenlab/crs70/projects/eSTRs/eSTRs/raw/master/Lung_master.tab


cut -f 9 $1 | grep -v motif > $1ForwardRepeat.txt
cut -f 10 $1 | grep -v motif > $1ReverseRepeat.txt


