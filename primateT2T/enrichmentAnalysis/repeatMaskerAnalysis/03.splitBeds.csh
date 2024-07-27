#!/bin/csh -evf

mkdir -p bedSplit

foreach bed (*.RepeatMaskerClass.bed)
	set bedPrefix = $bed:t:r
	mkdir -p bedSplit/$bedPrefix
	~/go/bin/bedSplit byName $bed bedSplit/$bedPrefix
	foreach b (bedSplit/$bedPrefix/*.bed)
		~/go/bin/bedMerge $b tmp.bed
		mv tmp.bed $b
	end
end

foreach bed (*.RepeatMaskerFamily.bed)
	set bedPrefix = $bed:t:r
	mkdir -p bedSplit/$bedPrefix
	~/go/bin/bedSplit byName $bed bedSplit/$bedPrefix
	foreach b (bedSplit/$bedPrefix/*.bed)
		~/go/bin/bedMerge $b tmp.bed
		mv tmp.bed $b
	end
end

echo DONE
