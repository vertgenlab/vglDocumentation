#!/bin/csh -ef

set roadmap = /hpc/group/vertgenlab/publicDataSets/RoadmapEpigenomics/15stateChromHmm/ByState

foreach state (`ls -1 $roadmap`)
	sbatch --wrap="./support.02.chromHmmBatchByState.csh $state"
end

echo DONE
