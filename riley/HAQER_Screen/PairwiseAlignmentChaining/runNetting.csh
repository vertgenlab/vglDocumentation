#!/bin/csh -ef

set input = hg38.panTro6.minScore50000.merged.chain
set t = hg38
set q = panTro6
set targetSizes = /data/lowelab/RefGenomes/hg38/hg38.chrom.sizes
set target2bit = /data/lowelab/RefGenomes/hg38/hg38.2bit
set querySizes = /data/lowelab/RefGenomes/panTro6/panTro6.chrom.sizes
set query2bit=/data/lowelab/RefGenomes/panTro6/panTro6.2bit

mkdir -p nets

chainPreNet $input $targetSizes $querySizes nets/$t.$q.sorted.merged_filtered.chain
chainNet nets/$t.$q.sorted.merged_filtered.chain $targetSizes $querySizes stdout /dev/null | netSyntenic stdin nets/syntenic_netted_chain.net
netToAxt nets/syntenic_netted_chain.net nets/$t.$q.sorted.merged_filtered.chain $target2bit $query2bit nets/$t.$q.chaining.FINAL.axt
axtToMaf -tPrefix=$t. -qPrefix=$q. nets/$t.$q.chaining.FINAL.axt $targetSizes $querySizes nets/$t.$q.chaining.FINAL.maf

echo DONE
