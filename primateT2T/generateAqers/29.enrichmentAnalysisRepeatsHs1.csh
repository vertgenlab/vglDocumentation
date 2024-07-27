#!/bin/csh -evf

set haqerSets = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/setsToFreeze/hs1
set tmp = /work/yl726/PrimateT2T_15way/repeatEnrichments
set byStateDir = $tmp/ByState
set dirs = `find $byStateDir -mindepth 1 -type d`

mkdir -p $tmp/results

foreach d ($dirs)
        echo $d:t
        foreach r ($haqerSets/*.bed)
               sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="./support.enrichmentAnalysisRepeatsHs1.csh $d $r"
        end
end

echo DONE
