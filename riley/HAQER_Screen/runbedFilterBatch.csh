#!/bin/csh -ef

set threshold=30

foreach file (*.bed)
	set prefix=$file:r
	/home/rjm60/go/bin/bedFilter -minScore $threshold $file filtered30/$prefix.filter$threshold.bed
end

echo DONE
