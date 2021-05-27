#!/bin/csh -ef

mkdir -p AncestorAnnotation
set faPath = /data/lowelab/riley/20200122_HAQER_Screen/findFastFiles/MessyToN

foreach v (*.vcf)
	set filename = `basename $v`
	set chr = $filename:r:e
	echo $chr
	set prefix = $v:r
	sbatch --mem=32G --wrap="/home/rjm60/go/bin/vcfAncestorAnnotation $v $faPath/$chr.Human.HCA.fa  AncestorAnnotation/$prefix.HcaAnnotation.vcf"

end

echo DONE
