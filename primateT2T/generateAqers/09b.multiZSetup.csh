#!/bin/csh -ef

set mafSplit = /hpc/group/vertgenlab/cl454/bin/x86_64/mafSplit

set tmp = /work/yl726/PrimateT2T_15way

set target = "humanT2T"

# there should be a list of assemblies in "assemblies.b.list", one per line
# based on code below, I think order doesn't matter
echo gorillaT2Tpri > assemblies.b.list
echo bonoboT2Tpri >> assemblies.b.list
echo chimpT2Tpri >> assemblies.b.list
echo orangutanT2Tpri >> assemblies.b.list
echo borangutanT2Tpri >> assemblies.b.list
echo gibbonT2Tpri >> assemblies.b.list
echo gorillaT2Talt >> assemblies.b.list
echo bonoboT2Talt >> assemblies.b.list
echo chimpT2Talt >> assemblies.b.list
echo orangutanT2Talt >> assemblies.b.list
echo borangutanT2Talt >> assemblies.b.list
echo gibbonT2Talt >> assemblies.b.list

# starting tree
set startingTree = trees/speciesOfInterest.b.nh
# manually make trees/speciesOfInterest.b.nh

# create species list and stripped down tree for autoMZ
# manually make trees/tree.nh
#sed 's/[a-z][a-z]*_//g; s/:[0-9\.][0-9\.]*//g; s/;//; /^ *$/d' $startingTree > tmp.nh
#echo `cat tmp.nh` | sed 's/ //g; s/,/ /g' > trees/tree.nh
sed 's/[()]//g; s/,/ /g' trees/tree.b.nh > trees/species.b.lst
#rm tmp.nh

mkdir -p $tmp/mafSplit

foreach db (`cat assemblies.b.list`)
        echo "working on $db"
        mkdir -p $tmp/mafSplit/$db
        $mafSplit -byTarget -useFullSequenceName /dev/null $tmp/mafSplit/$db/"$db"_ $tmp/nets/$target.$db.chaining.refilter.FINAL.maf
end

echo DONE
