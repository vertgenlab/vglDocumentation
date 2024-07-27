#!/bin/bash

cat collapseHg19.hipstr_reference.txt |\
       	awk 'BEGIN {FS = "\t"} {print $2, $1}'\
	> flippedCollapseHg19HipRef.txt

cat seqCountSortHipstrPromoterSequelOverlapOutput.txt |\
	awk 'BEGIN {FS = "\t"} {prting $2, $1}'\
	> flippedSeqCountSortHipPromoterSequelOverlapOut.txt

join -o 0,1.2,2.2 -e 0 -a1 -a2 flippedCollapseHg19HipRef.txt flippedSeqCountSortHipPromoterSequelOverlapOut.txt > joinStrTotalHipstrTotalPromoter.txt

cat joinStrTotalHipstrTotalPromoter.txt | awk '{ print $1, $2, $3, ($2-$3)}' > joinStrTotalHipstrTotalPromoterTotalNonPromoter.txt
