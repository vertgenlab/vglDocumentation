#!/bin/csh -ef

set samtools = "/hpc/group/vertgenlab/cl454/src/samtools/samtools-1.13/samtools"

#foreach prefix (`ls -1 mappedReads/*.SRR*.sorted.bam | cut -d '.' -f 1,2,3 | sort | uniq`)
foreach prefix (`ls -1 mappedReads/stickleback_v5_assembly.*.SRR*.sorted.bam | cut -d '.' -f 1,2,3 | sort | uniq`)
	set n = $prefix:t
	echo $prefix $n
	if ( -e mappedReads/$n.merged.sorted.bam ) then
		echo mappedReads/$n.merged.sorted.bam already exists
	else
		$samtools merge -@ 8 mappedReads/$n.merged.sorted.bam mappedReads/$n.SRR*.sorted.bam
	endif
end

echo DONE

