#!/bin/bash

## Brain-CerebellumSig_master.txt was created in the sigHipstrFractionDNA.sh script. It is filtered on it $21 == TRUE using AWK. Note this was done before realizing AWK needed the FS and OFS change so this list would need to be reproduced for future analysis. 

cat Brain-CerebellumSig_master.txt | awk '{ if ($26 >= 0.3) print}' | cut -f 9 > patternsFiles/forwardTempBrain-CerebellumSigCaviar.txt

cat Brain-CerebellumSig_master.txt | awk '{ if ($26 >= 0.3) print}' | cut -f 10 > patternsFiles/reverseTempBrain-CerebellumSigCaviar.txt

cat patternsFiles/forwardTempBrain-CerebellumSigCaviar.txt patternsFiles/reverseTempBrain-CerebellumSigCaviar.txt | sort | uniq -c > patternsFiles/bothFRTempBrain-CerebellumSigCaviar.txt

 join -1 2 -2 2 patternsFiles/bothFRTempBrain-CerebellumSigCaviar.txt patternsFiles/commonFiveOrMoreTissuesTotalEstr.txt > patternsFiles/Brain-CerebellumEstrSigCaviarCountBrainCountSigTissues.txt
