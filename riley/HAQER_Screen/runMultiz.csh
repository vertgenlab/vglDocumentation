#!/bin/csh -efx

set db = "hg38"
set tmpDir = "tmp"
set workDir = "work"
#set threshold = 100000
set chromList = "chroms.list"
set assemblyList = "assemblies.list"

set pennBin = "/home/rjm60/src/multiz"

mkdir -p output
mkdir -p $workDir
cd $workDir
mkdir -p $tmpDir

foreach c (`cat ../$chromList | grep -v -e alt -e random -e Un -e M`)
	foreach s (`cat ../$assemblyList`)

    		set in = ../mafSplit/$s/"$s"_"$c".maf
    		set out = $db.$s.sing.maf
		if ($s == $db) then
			continue
	    	endif
    		if (-e $in.gz) then
			zcat $in.gz > $out
	    	else if (-e $in) then
			cp $in $out
	    	else
			echo "##maf version=1 scoring=autoMZ" > $out
	    	endif

	end
	set path = ($pennBin $path)
	rehash
	roast + T=$tmpDir E=$db "`cat ../trees/tree.nh`" $db.*.sing.maf $c.maf
	mv $c.maf ../output/$c.maf
	rm *.maf
end
echo DONE
