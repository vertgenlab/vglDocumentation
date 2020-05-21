#!/bin/csh -e

 set db = "galGal6"
 
 foreach species (`cat species.list | grep -v $db`) 
	echo ./mafToBedSpeciesArg.csh $species \
	>> galGal6AlignArray.txt

end

echo Done
