#!/bin/bash

cat Cells-TransformedfibroblastsSig_master.txt | awk '{ if ($26 >= 0.3) print}' | cut -f 9 > patternsFiles/forwardTempCells-TransformedfibroblastsSigCaviar.txt

cat Cells-TransformedfibroblastsSig_master.txt | awk '{ if ($26 >= 0.3) print}' | cut -f 10 > patternsFiles/reverseTempCells-TransformedfibroblastsSigCaviar.txt

cat patternsFiles/forwardTempCells-TransformedfibroblastsSigCaviar.txt patternsFiles/reverseTempCells-TransformedfibroblastsSigCaviar.txt | sort | uniq -c > patternsFiles/bothFRTempCells-TransformedfibroblastsSigCaviar.txt


join -1 2 -2 2 patternsFiles/bothFRTempCells-TransformedfibroblastsSigCaviar.txt patternsFiles/commonFiveOrMoreTissuesTotalEstr.txt > patternsFiles/Cells-TransformedfibroblastsEstrSigCaviarCountSigTissuesCount.txt
