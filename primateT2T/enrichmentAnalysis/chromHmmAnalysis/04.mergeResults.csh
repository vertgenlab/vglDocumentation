#!/bin/csh -ef


foreach dir (`ls -1 output`)
	cat output/$dir/*.txt | grep -v '#' > output/$dir.merged.txt
end

cat output/*.txt > chromHmm.Enrichment.summary.txt

echo DONE
