#!/bin/csh -evf

# set

# bigMaf
# without frame (because we have no gp file)
# with summary
wget https://genome.ucsc.edu/goldenPath/help/examples/bigMaf.as
wget https://genome.ucsc.edu/goldenPath/help/examples/mafSummary.as
set bedToBigBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed
set mafToBigMaf = /hpc/group/vertgenlab/cl454/bin/x86_64/mafToBigMaf
set hgLoadMafSummary = /hpc/group/vertgenlab/cl454/bin/x86_64/hgLoadMafSummary

# dir
set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/bigMafsb

# target
set target = "humanT2T"
set targetDb = "hs1"
set tSizes = $tmp/$target.chrom.sizes

# execute

foreach m ($tmp/outputb/*.maf)
	echo $m
	set mFile = `basename $m`
	echo $mFile
	set prefix = $mFile:r
	echo $prefix

	awk -v srch="humanT2T" -v repl="hs1" '{ sub(srch,repl,$0); print $0}' $m > $tmp/bigMafsb/$prefix.forBigMaf.maf

	# bigMaf
	# generate bigMaf file
	$mafToBigMaf $targetDb $tmp/bigMafsb/$prefix.forBigMaf.maf stdout | sort -k1,1 -k2,2n > $tmp/bigMafsb/$prefix.bigMaf.txt
	$bedToBigBed -type=bed3+1 -as=bigMaf.as -tab $tmp/bigMafsb/$prefix.bigMaf.txt $tSizes $tmp/bigMafsb/$prefix.bigMaf.bb
	# generate bigMaf summary
	# bigMafSummary.tab and bigMafSUmmary.bed will be overwritten for each new maf
	$hgLoadMafSummary -minSeqSize=1 -test $targetDb bigMafSummary $tmp/bigMafsb/$prefix.forBigMaf.maf
	cut -f2- bigMafSummary.tab | sort -k1,1 -k2,2n > bigMafSummary.bed
	$bedToBigBed -type=bed3+4 -as=mafSummary.as -tab bigMafSummary.bed $tSizes $tmp/bigMafsb/$prefix.bigMafSummary.bb
 	# remove intermediate files (anything that's not bigMaf.bb or bigMafSummary.bb)
        rm $tmp/bigMafsb/$prefix.forBigMaf.maf
	rm $tmp/bigMafsb/$prefix.bigMaf.txt

end

# remove intermediate files
rm bigMafSummary.tab
rm bigMafSummary.bed
rm bigMaf.as
rm mafSummary.as

echo DONE
