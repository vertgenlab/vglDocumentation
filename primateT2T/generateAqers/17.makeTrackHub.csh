#!/bin/csh -evf

# set
set tmp = /work/yl726/PrimateT2T_15way
set assembly = "hs1"
set trackHubDir = /datacommons/vertgenlab/publicGenomeBrowser/raven/PrimateT2T_15way
set urlPrefix = "https://vertgenlab.cloud.duke.edu/raven/PrimateT2T_15way/t2tTrackHub/$assembly"

# mkdir
mkdir -p $trackHubDir
mkdir -p $trackHubDir/t2tTrackHub
mkdir -p $trackHubDir/t2tTrackHub/$assembly

# make hub.txt file
echo "hub t2tTrackHub" > $trackHubDir/t2tTrackHub/hub.txt
echo "shortLabel t2tTrackHub" >> $trackHubDir/t2tTrackHub/hub.txt
echo "longLabel Divergence tracks, significance tracks, and Peak Calls" >> $trackHubDir/t2tTrackHub/hub.txt
echo "email yanting.luo@duke.edu" >> $trackHubDir/t2tTrackHub/hub.txt
echo "genomesFile genomes.txt" >> $trackHubDir/t2tTrackHub/hub.txt

# make genomes.txt
echo "genome hs1" > $trackHubDir/t2tTrackHub/genomes.txt
echo "trackDb trackDb.txt" >> $trackHubDir/t2tTrackHub/genomes.txt

# make trackDb.txt
echo "track HaqerPrimateT2T" > $trackHubDir/t2tTrackHub/trackDb.txt
echo "shortLabel haqerPrimateT2T" >> $trackHubDir/t2tTrackHub/trackDb.txt
echo "longLabel haqerPrimateT2T" >> $trackHubDir/t2tTrackHub/trackDb.txt
echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt

# bigWig
foreach bw ($tmp/wig/*.bw)
       set bFile = `basename $bw`
       set prefix = $bFile:r
       cp $bw $trackHubDir/t2tTrackHub/$assembly
       echo "track $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
       echo "type bigWig" >> $trackHubDir/t2tTrackHub/trackDb.txt
       echo "bigDataUrl $urlPrefix/$bFile" >> $trackHubDir/t2tTrackHub/trackDb.txt
       echo "shortLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
       echo "longLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
       echo "visibility dense" >> $trackHubDir/t2tTrackHub/trackDb.txt
       echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt
end

# bigBed
#foreach bed ($tmp/haqerTmp/haqer.*.bb)
#        set bFile = `basename $bed`
#        set prefix = $bFile:r
#        cp $bed $trackHubDir/t2tTrackHub/$assembly
#        echo "track $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
#        echo "type bigBed" >> $trackHubDir/t2tTrackHub/trackDb.txt
#        echo "bigDataUrl $urlPrefix/$bFile" >> $trackHubDir/t2tTrackHub/trackDb.txt
#        echo "shortLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
#        echo "longLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
#        echo "visibility dense" >> $trackHubDir/t2tTrackHub/trackDb.txt
#        echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt
#end
foreach bed ($tmp/haqerTmpb/haqer.*.bb)
        set bFile = `basename $bed`
        set prefix = $bFile:r
        cp $bed $trackHubDir/t2tTrackHub/$assembly
        echo "track $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "type bigBed" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "bigDataUrl $urlPrefix/$bFile" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "shortLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "longLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "visibility dense" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt
end

# bigChain
# check if priority ranking works out numerically/alphabetically
foreach bc ($tmp/bigChains/*.refilter.bigChain.bb)
        set bcFile = `basename $bc`
        set prefix = $bcFile:r:r:r
        cp $bc $tmp/bigChains/$prefix.refilter.bigChain.link.bb $trackHubDir/t2tTrackHub/$assembly
        echo "track $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "type bigChain" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "bigDataUrl $urlPrefix/$bcFile" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "linkDataUrl $urlPrefix/$prefix.refilter.bigChain.link.bb" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "shortLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "longLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "visibility squish" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "group bigChain" >> $trackHubDir/t2tTrackHub/trackDb.txt

if ($prefix == "humanT2T.chimpT2Tpri") then
        echo "priority 1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.chimpT2Tpri.splitChains") then
        echo "priority 1.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.chimpT2Talt") then
        echo "priority 1.2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.chimpT2Talt.splitChains") then
        echo "priority 1.3" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.gorillaT2Tpri") then
        echo "priority 2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.gorillaT2Tpri.splitChains") then
        echo "priority 2.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.gorillaT2Talt") then
        echo "priority 2.2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.gorillaT2Talt.splitChains") then
        echo "priority 2.3" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.bonoboT2Tpri") then
        echo "priority 3" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.bonoboT2Tpri.splitChains") then
        echo "priority 3.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.bonoboT2Talt") then
        echo "priority 3.2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.bonoboT2Talt.splitChains") then
        echo "priority 3.3" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.orangutanT2Tpri") then
        echo "priority 4" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.orangutanT2Tpri.splitChains") then
        echo "priority 4.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.orangutanT2Talt") then
        echo "priority 4.2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.orangutanT2Talt.splitChains") then
        echo "priority 4.3" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.humanGapped") then
        echo "priority 5" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.humanGapped.splitChains") then
        echo "priority 5.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.chimpGapped") then
        echo "priority 6" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.chimpGapped.splitChains") then
        echo "priority 6.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.gorillaGapped") then
        echo "priority 7" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.gorillaGapped.splitChains") then
        echo "priority 7.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.bonoboGapped") then
        echo "priority 8" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.bonoboGapped.splitChains") then
        echo "priority 8.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.orangutanGapped") then
        echo "priority 9" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.orangutanGapped.splitChains") then
        echo "priority 9.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.HG002mat") then
        echo "priority 10" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.HG002mat.splitChains") then
        echo "priority 10.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.HG002pat") then
        echo "priority 10.2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.HG002pat.splitChains") then
        echo "priority 10.3" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.CN1mat") then
        echo "priority 10.4" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.CN1mat.splitChains") then
        echo "priority 10.5" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.CN1pat") then
        echo "priority 10.6" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.CN1pat.splitChains") then
        echo "priority 10.7" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.Han1") then
        echo "priority 10.8" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.Han1.splitChains") then
        echo "priority 10.9" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.YAOmat") then
        echo "priority 11" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.YAOmat.splitChains") then
        echo "priority 11.1" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.YAOpat") then
        echo "priority 11.2" >> $trackHubDir/t2tTrackHub/trackDb.txt
else if ($prefix == "humanT2T.YAOpat.splitChains") then
        echo "priority 11.3" >> $trackHubDir/t2tTrackHub/trackDb.txt
endif

     	echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt
end

# bigMaf
foreach bm ($tmp/bigMafs/*.bigMaf.bb)
        set bmFile = `basename $bm`
        set prefix = $bmFile:r:r
        cp $bm $tmp/bigMafs/$prefix.bigMafSummary.bb $trackHubDir/t2tTrackHub/$assembly
        echo "track $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "type bigMaf" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "bigDataUrl $urlPrefix/$bmFile" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "summary $urlPrefix/$prefix.bigMafSummary.bb" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "shortLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "longLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "visibility pack" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "group bigMaf" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt
end

# haqer bigBed
set target = "humanT2T"
set tSizes = $tmp/$target.chrom.sizes
set bedToBigBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed

foreach bed (haqerBed/*.bed)
        set bFile = `basename $bed`
        set prefix = $bFile:r

       $bedToBigBed $bed $tSizes $trackHubDir/t2tTrackHub/$assembly/$prefix.bigBed.bb

        echo "track $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "type bigBed" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "bigDataUrl $urlPrefix/$prefix.bigBed.bb" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "shortLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "longLabel $prefix" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "visibility dense" >> $trackHubDir/t2tTrackHub/trackDb.txt
        echo "" >> $trackHubDir/t2tTrackHub/trackDb.txt
end

echo DONE
