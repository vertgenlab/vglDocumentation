#!/bin/csh -evf

#set tmp = /work/yl726/PrimateT2T_15way
#mkdir -p $tmp/wig
set aqerList = ("caqerPri" "caqerAlt" "baqerPri" "baqerAlt" "gaqerPri" "gaqerAlt")

foreach aqer ($aqerList)
        echo $aqer
        sbatch --mem=64G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J $aqer --wrap="./support.upstreamPipeline4.csh $aqer"
end

echo DONE
