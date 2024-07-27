#!/bin/csh -ef

set tmp = /work/yl726/PrimateT2T_15way
#set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "orangutanT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt" "orangutanT2Talt" "humanGapped" "chimpGapped" "gorillaGapped" "bonoboGapped" "orangutanGapped" "HG002mat" "HG002pat" "YAOmat" "YAOpat" "Han1" "CN1mat" "CN1pat")
#set queries = ("HG002mat" "HG002pat" "YAOmat" "YAOpat" "Han1" "CN1mat" "CN1pat")
set queries = ("borangutanT2Tpri" "gibbonT2Tpri" "borangutanT2Talt" "gibbonT2Talt")
set lastz=/hpc/group/vertgenlab/softwareShared/lastz-master/src/lastz
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/human_chimp_v2.mat
set target = "humanT2T"
set targetDir=$tmp/$target.byChrom

mkdir -p $tmp/alignments

foreach query ($queries)
        echo "Working on" $query
        touch $tmp/$query.lastz.jobs.txt
        rm $tmp/$query.lastz.jobs.txt
        set outDir=$tmp/alignments/pairwise.$target.$query
        mkdir -p $outDir
        set queryDir = $tmp/$query.byChrom
        foreach t (`ls -1 $targetDir`)
                echo $t
                set tNAME = $t:r
                mkdir -p $outDir/$tNAME
                foreach q (`ls -1 $queryDir`)
                        echo $q
                        set qNAME = $q:r
                        echo "$lastz $targetDir/$t $queryDir/$q --output=$outDir/$tNAME/$qNAME.$tNAME.axt --scores=$matrix --format=axt O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000" >> $tmp/$query.lastz.jobs.txt
                end
        end
end

# same-species alignments need --allocate:traceback higher memory
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/humanGapped.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/HG002mat.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/HG002pat.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/YAOmat.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/YAOpat.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/CN1mat.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/CN1pat.lastz.jobs.txt
#sed -e 's/$/ --allocate:traceback=1G/' -i $tmp/Han1.lastz.jobs.txt

echo DONE
