#!/bin/csh -evf

set target = chimpT2Tpri
set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/workbCAQER
mkdir -p $tmp/tmpbCAQER
mkdir -p $tmp/outputbCAQER
set work = $tmp/workbCAQER
set chromList = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/chroms.list

set multiZ = /hpc/group/vertgenlab/softwareShared/multiz-tba.012109/
set queries = (humanT2T bonoboT2Tpri gorillaT2Tpri orangutanT2Tpri chimpT2Talt bonoboT2Talt gorillaT2Talt orangutanT2Talt)

set path = ($multiZ $path)
rehash

echo $path

cd $work

foreach c (`cat $chromList`)
        foreach q ($queries)
                cp $tmp/mafSplit/$q/"$q"_"$c".maf $target.$q.sing.maf
        end
	roast + T=$tmp/tmpbCAQER E=$target "`cat /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/trees/tree.b.nh`" $target.*.sing.maf $c.maf
        mv $c.maf $tmp/outputbCAQER/$c.maf
        rm *.maf
end

echo DONE
