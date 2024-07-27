#!/bin/csh -evf

set target = humanT2T
set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/workb
mkdir -p $tmp/tmpb
mkdir -p $tmp/outputb
set work = $tmp/workb
set chromList = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/chroms.list

set multiZ = /hpc/group/vertgenlab/softwareShared/multiz-tba.012109/
set queries = (chimpT2Tpri bonoboT2Tpri gorillaT2Tpri orangutanT2Tpri borangutanT2Tpri gibbonT2Tpri chimpT2Talt bonoboT2Talt gorillaT2Talt orangutanT2Talt borangutanT2Talt gibbonT2Talt)

set path = ($multiZ $path)
rehash

echo $path

cd $work

foreach c (`cat $chromList`)
        foreach q ($queries)
                cp $tmp/mafSplit/$q/"$q"_"$c".maf $target.$q.sing.maf
        end
	roast + T=$tmp/tmpb E=$target "`cat /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/trees/tree.b.nh`" $target.*.sing.maf $c.maf
        mv $c.maf $tmp/outputb/$c.maf
        rm *.maf
end

echo DONE
