#!/bin/csh -evf

foreach db (hg38 mm39 canFam4 bosTau9 galGal6 gasAcu1)
foreach species (`cat /work/cf189/runPairwiseAlignments/species.list`)
echo $db
if ($species != $db) then

touch $db.$species.bed
rm $db.$species.bed
touch $db.$species.bed
echo $species

foreach b ($db.$species/$db.*.$species.syntenic.bed)
echo $b

        cat $b >> $db.$species.bed

end
endif
end
end
echo DONE

