#!/bin/bash

cat chr11297578grabMasterLineAllTissues.txt | awk 'BEGIN{FS=" "}{print $1, $3, $8, $9, $26, $31, $33}' > tempChr11_297578.bed

