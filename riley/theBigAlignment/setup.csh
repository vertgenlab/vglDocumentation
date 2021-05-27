#!/bin/csh -ef

set mafSplit = mafSplit
#set threshold = 500000
#module add kentUtils

 # reference assembly
set ref = "hg38"

# there should be a list of assemblies in "assemblies.list", one per line
#echo "gorGor5" > assemblies.list
#echo "panPan2" >> assemblies.list
#echo "panTro6" >> assemblies.list
#echo "ponAbe3" >> assemblies.list

# starting tree
#set startingTree = "trees/speciesOfInterest.nh"

# create species list and stripped down tree for autoMZ
#sed 's/[a-z][a-z]*_//g; s/:[0-9\.][0-9\.]*//g; s/;//; /^ *$/d' $startingTree > tmp.nh
#echo `cat tmp.nh` | sed 's/ //g; s/,/ /g' > trees/tree.nh
sed 's/[()]//g; s/,/ /g' trees/tree.nh > trees/species.lst
#rm tmp.nh

# syntenic nets should be placed in the "pairwise" directory
# with names like hg38.gorGor5.synNet.maf.gz

mkdir -p mafSplit
cd mafSplit

foreach db (`cat ../assemblies.list`)
	echo "working on $db"
	cat ../rawPairwise/$ref.$db.synNet.maf > $db.maf
    	mkdir -p $db
    	$mafSplit -byTarget -useFullSequenceName /dev/null $db/"$db"_ $db.maf
    	rm $db.maf
	echo "done splitting $db"
end
cd ..

echo DONE
