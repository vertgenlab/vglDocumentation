#!/bin/csh -ef

bedtools intersect -wa -a regions/human.bed -b /datacommons/vertgenlab/publicGenomeBrowser/publications/haqer/regionsOfInterest/haqersByAssembly/haqer.hg38.bed | sort | uniq > shared.hg38.showGapped.bed
set roadmap = /hpc/group/vertgenlab/publicDataSets/RoadmapEpigenomics/15stateChromHmm/ByState

foreach state (`ls -1 $roadmap`)
	echo $state
	sbatch --wrap="./support.03.chromHmmShared.csh $state"
end

echo DONE
