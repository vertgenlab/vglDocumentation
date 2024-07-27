#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way

#foreach file (`ls -1 $tmp/rawFab/*.fa`)
foreach file (`ls -1 /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/multizFa/*.fa`)
        set chr = $file:t:r
        echo $chr
        sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J $chr --wrap="./support.upstreamPipeline3.csh $chr"
end

echo DONE
