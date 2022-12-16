#!/bin/bash

cat totalEstrStudied.txt | cut -d " " -f 2 > onlyUniqSeqAllEstrStudied.txt

cat collapseHg19.hipstr_reference.txt | cut -d   -f 2 > onlyUniqSeqHipstrReference.txt
