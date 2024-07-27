#!/bin/bash

cat mart_export.txt | awk ' BEGIN { OFS = "\t"} {if($4 == "-1") $4="-"; else if ($4=="1") $4="+"; print "chr"$1, $2-1, $2, $3, 0, $4}' > hg19MartExportGeneTssStrand.bed 

sed -i '1d' hg19MartExportGeneTssStrand.bed

cat hg19MartExportGeneTssStrand.bed | grep -v "GL000" | grep -v "CTG" | grep -v "HG" | grep -v "HSCHR" | grep -v "MT" | sort -k1,1 -k2,2n > hg19MartExportGeneTssStrandIrregChrRemovedSorted.bed

/hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed hg19MartExportGeneTssStrandIrregChrRemovedSorted.bed /hpc/group/vertgenlab/crs70/refGenomes/hg19/hg19.chrom.sizes hg19MartExportGeneTssStrandIrregChrRemovedSorted.bb

