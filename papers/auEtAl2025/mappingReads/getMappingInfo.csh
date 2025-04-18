#!/bin/csh -ef

set samtools = "/hpc/group/vertgenlab/cl454/src/samtools/samtools-1.13/samtools"

foreach f (`ls -1 mappedReads/gasAcu1.*.merged.sorted.bam | grep -e AKMA -e AKST`)
	set prefix = $f:t:r:r:r
	set sal = $prefix:e
	set pop = $prefix:r:e
	set n = $pop.$sal
	set g = `$samtools flagstat mappedReads/gasAcu1.$n.merged.sorted.bam        | grep '0 mapped (' | cut -d ' ' -f 5 | cut -d '(' -f 2 | cut -d '%' -f 1`
	set r = `$samtools flagstat mappedReads/rabsTHREEspine.$n.merged.sorted.bam | grep '0 mapped (' | cut -d ' ' -f 5 | cut -d '(' -f 2 | cut -d '%' -f 1`
	set u = `$samtools flagstat mappedReads/UGAv5.$n.merged.sorted.bam          | grep '0 mapped (' | cut -d ' ' -f 5 | cut -d '(' -f 2 | cut -d '%' -f 1`
	set c = `$samtools flagstat mappedReads/stickleback_v5_assembly.$n.merged.sorted.bam          | grep '0 mapped (' | cut -d ' ' -f 5 | cut -d '(' -f 2 | cut -d '%' -f 1`
	set ug = `echo 100 - $g | /hpc/group/vertgenlab/cl454/src/bc/bc-1.08.1/bc/bc -l`
	set ur = `echo 100 - $r | /hpc/group/vertgenlab/cl454/src/bc/bc-1.08.1/bc/bc -l`
	set uu = `echo 100 - $u | /hpc/group/vertgenlab/cl454/src/bc/bc-1.08.1/bc/bc -l`
	set uc = `echo 100 - $c | /hpc/group/vertgenlab/cl454/src/bc/bc-1.08.1/bc/bc -l`
	echo $n $ug $uu $uc $ur
end

echo DONE

