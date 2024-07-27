#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way
set byStateDir = /hpc/group/vertgenlab/raven/raven/GWAS
set dirs = `find $byStateDir -mindepth 1 -type d`
set haqerSets = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/setsToFreeze/hg38

mkdir -p $tmp/frozenGwasEnrichments

foreach d ($dirs)
        echo $d:t
	foreach r ($haqerSets/*.bed)
            sbatch --mem=16G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="./support.enrichmentAnalysisGwas.csh $d $r"
        end
end

echo DONE
