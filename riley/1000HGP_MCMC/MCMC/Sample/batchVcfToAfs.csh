#!/bin/csh -ef

foreach v (*.vcf) 
	set prefix = $v:r
	~/go/bin/vcfAFS $v AFS/$prefix.AFS.txt
end

echo DONE
