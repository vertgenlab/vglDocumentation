#!/bin/bash

cat hg19.hipstr_reference.bed | awk '{ print $1, $2, $3, $7}' | tr " " "\t" > hg19HipsterReference.bed

NEED TO ADD CODE FOR MAKING THE allEstr BED. 
