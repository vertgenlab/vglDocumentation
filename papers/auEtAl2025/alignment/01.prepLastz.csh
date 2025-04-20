#!/bin/csh -evf

# paths
set gasAcu1 = gasAcu1.fa
set rabsTHREEspine = rabsTHREEspine.fa

# tools
set faSplit = /hpc/group/vertgenlab/cl454/bin/x86_64/faSplit
set lastz = /hpc/group/vertgenlab/softwareShared/lastz-master/src/lastz

# parameters
set matrix = /hpc/group/vertgenlab/alignmentSupportFiles/human_chimp_v2.mat

# prep genomes
mkdir -p rabsTHREEspine.byChrom
$faSplit byname $rabsTHREEspine rabsTHREEspine.byChrom/

# array setup
set target = "gasAcu1"
set query = "rabsTHREEspine"
set targetDir = $target.byChrom
set queryDir = $query.byChrom
touch $target.$query.lastz.jobs.txt
rm $target.$query.lastz.jobs.txt
set outDir = pairwise.$target.$query
mkdir $outDir
foreach t (`ls -1 $targetDir`)
    set tNAME = `echo $t:r | sed 's/gasAcu1\.//'`
    mkdir -p $outDir/$tNAME
    foreach q (`ls -1 $queryDir`)
        set qNAME = $q:r
        echo "$lastz $targetDir/$t $queryDir/$q --output=$outDir/$tNAME/$qNAME.$tNAME.axt --scores=$matrix --format=axt O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000 --allocate:traceback=1G" >> $target.$query.lastz.jobs.txt
    end
end

echo DONE
