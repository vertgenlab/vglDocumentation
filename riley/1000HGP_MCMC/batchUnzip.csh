#!/bin/csh -ef

foreach g(*.gz)
	sbatch --wrap="gzip -d $g"
end

echo DONE
