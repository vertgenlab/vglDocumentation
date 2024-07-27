#!/bin/csh -ef

set mafSplit = /hpc/group/vertgenlab/cl454/bin/x86_64/mafSplit

set tmp = /work/yl726/PrimateT2T_15way

set target = "humanT2T"

# there should be a list of assemblies in "assemblies.list", one per line
# based on code below, I think order doesn't matter
echo gorillaT2Tpri > assemblies.list
echo bonoboT2Tpri >> assemblies.list
echo chimpT2Tpri >> assemblies.list
echo orangutanT2Tpri >> assemblies.list
echo gorillaT2Talt >> assemblies.list
echo bonoboT2Talt >> assemblies.list
echo chimpT2Talt >> assemblies.list
echo orangutanT2Talt >> assemblies.list
echo humanGapped >> assemblies.list
echo gorillaGapped >> assemblies.list
echo bonoboGapped >> assemblies.list
echo chimpGapped >> assemblies.list
echo orangutanGapped >> assemblies.list
echo HG002mat >> assemblies.list
echo HG002pat >> assemblies.list
echo YAOmat >> assemblies.list
echo YAOpat >> assemblies.list
echo Han1 >> assemblies.list
echo CN1mat >> assemblies.list
echo CN1pat >> assemblies.list

# starting tree
set startingTree = trees/speciesOfInterest.nh
# manually make trees/speciesOfInterest.nh

# create species list and stripped down tree for autoMZ
# manually make trees/tree.nh
#sed 's/[a-z][a-z]*_//g; s/:[0-9\.][0-9\.]*//g; s/;//; /^ *$/d' $startingTree > tmp.nh
#echo `cat tmp.nh` | sed 's/ //g; s/,/ /g' > trees/tree.nh
sed 's/[()]//g; s/,/ /g' trees/tree.nh > trees/species.lst
#rm tmp.nh

mkdir -p $tmp/mafSplit

foreach db (`cat assemblies.list`)
        echo "working on $db"
        mkdir -p $tmp/mafSplit/$db
        $mafSplit -byTarget -useFullSequenceName /dev/null $tmp/mafSplit/$db/"$db"_ $tmp/nets/$target.$db.chaining.refilter.FINAL.maf
end

echo DONE
