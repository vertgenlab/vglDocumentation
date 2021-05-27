#!/bin/csh -ef

set db = "hg38"
set tmpDir = "tmp"
set workDir = "work"
#set threshold = 500000
set chromList = "chroms.list"
set assemblyList = "assemblies.list"

set pennBin = "/home/rjm60/src/multiz"

mkdir -p output
mkdir -p $workDir
cd $workDir
mkdir -p $tmpDir

foreach c (`cat ../$chromList | grep -v -e alt -e random -e chr22 -e Un -e M`)
	foreach s (`cat ../$assemblyList`)

    		set in = ../mafSplit/$s/"$s"_"$c".maf
    		echo $in
		set out = $db.$s.sing.maf
		if ($s == $db) then
			continue
	    	endif
    		if (-e $in.gz) then
			echo "Found Zip"
			zcat $in.gz > $out
	    	else if (-e $in) then
			cp $in $out
			echo "Found regular"
	    	else
			echo "Didn't find it"
			echo "##maf version=1 scoring=autoMZ" > $out
	    	endif

	end
	#echo "Print sing number"
	#echo `ls *.sing.maf | wc -l`
	set path = ($pennBin $path)
	rehash
	roast + T=$tmpDir E=$db "`cat ../trees/tree.nh`" $db.*.sing.maf $c.maf
	mv $c.maf ../output/$c.maf
	#rm *.maf
end
echo DONE
