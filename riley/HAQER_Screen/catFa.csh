#!/bin/csh -ef

foreach file (*.Human.fa)
	set chr=$file:r:r
	cat $file $chr.HCA.fa > $chr.Human.HCA.fa
end

echo DONE
