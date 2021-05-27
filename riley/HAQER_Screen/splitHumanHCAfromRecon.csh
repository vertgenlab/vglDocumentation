#!/bin/csh -ef

mkdir -p ../findFastFiles

foreach file (*.fa)
	set prefix=$file:r:r
	/home/rjm60/go/bin/faFilter -name hg38 $file ../findFastFiles/$prefix.Human.fa
	/home/rjm60/go/bin/faFilter -name Human_Chimp_Ancestor $file ../findFastFiles/$prefix.HCA.fa
end

echo DONE
