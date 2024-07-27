#!/bin/csh -evf

set byStateDir = /hpc/group/vertgenlab/publicDataSets/RoadmapEpigenomics/15stateChromHmm/ByState
set dirs = `find $byStateDir -mindepth 1 -type d`
set haqerSets = /work/yl726/PrimateT2T_15way/nhp-aqerOverlapSets
set tmp = /work/yl726/PrimateT2T_15way/frozenNhpaqerChromhmmEnrichments

mkdir -p $tmp

foreach d ($dirs)
        echo $d:t
        foreach r ($haqerSets/*.bed)
               sbatch --mem=16G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="./support.enrichmentAnalysisNhpAqer.csh $d $r"
        end
end

echo DONE
