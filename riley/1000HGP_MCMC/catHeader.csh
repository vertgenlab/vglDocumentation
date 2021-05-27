#!/bin/csh -ef

foreach v (*.vcf)
	cat ../highCoverage.header.txt > tmp.txt
	cat $v >> tmp.txt
	mv tmp.txt $v
end

echo DONE
