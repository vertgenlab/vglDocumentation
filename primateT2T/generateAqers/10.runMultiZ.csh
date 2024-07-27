#!/bin/csh -evf

set target = humanT2T
set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/work
mkdir -p $tmp/tmp
mkdir -p $tmp/output
set work = $tmp/work
#set chromList = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/chroms.list
set chromList = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/startfromchr2.chroms.list

set multiZ = /hpc/group/vertgenlab/softwareShared/multiz-tba.012109/
set queries = (chimpT2Tpri bonoboT2Tpri gorillaT2Tpri orangutanT2Tpri chimpT2Talt bonoboT2Talt gorillaT2Talt orangutanT2Talt humanGapped chimpGapped bonoboGapped gorillaGapped orangutanGapped HG002mat HG002pat YAOmat YAOpat Han1 CN1mat CN1pat)

set path = ($multiZ $path)
rehash

echo $path

cd $work

foreach c (`cat $chromList`)
        foreach q ($queries)
                cp $tmp/mafSplit/$q/"$q"_"$c".maf $target.$q.sing.maf
        end
	roast + T=$tmp/tmp E=$target "`cat /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/trees/tree.nh`" $target.*.sing.maf $c.maf
        mv $c.maf $tmp/output/$c.maf
        rm *.maf
end

echo DONE
