#!/bin/csh -ef

touch mappingJobs.list
rm mappingJobs.list

foreach a (`ls -1 assemblies/*.fa`)
	foreach f (`ls -1 reads/*.*.srr.list`)
		set n = $f:t:r:r
		foreach srr (`cat $f`)
			echo $a $srr $n.$srr >> mappingJobs.list
		end
	end
end

echo DONE
