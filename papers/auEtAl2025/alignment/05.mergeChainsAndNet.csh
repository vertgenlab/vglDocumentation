#!/bin/csh -evf

# paths
mkdir -p mergedChains
mkdir -p nets

# tools
set chainSort =  /hpc/group/vertgenlab/cl454/bin/x86_64/chainSort
set chainPreNet = /hpc/group/vertgenlab/cl454/bin/x86_64/chainPreNet
set chainNet = /hpc/group/vertgenlab/cl454/bin/x86_64/chainNet
set chainFilter = /hpc/group/vertgenlab/cl454/bin/x86_64/chainFilter
set netSyntenic = /hpc/group/vertgenlab/cl454/bin/x86_64/netSyntenic
set netToAxt = /hpc/group/vertgenlab/cl454/bin/x86_64/netToAxt
set axtToMaf = /hpc/group/vertgenlab/cl454/bin/x86_64/axtToMaf
set chainMergeSort = /hpc/group/vertgenlab/cl454/bin/x86_64/chainMergeSort
set netChainSubset = /hpc/group/vertgenlab/cl454/bin/x86_64/netChainSubset
set chainStitchId = /hpc/group/vertgenlab/cl454/bin/x86_64/chainStitchId
#set lift = /hpc/group/vertgenlab/cl454/bin/x86_64/liftOver

# parameters
set target = "gasAcu1"
set q = "rabsTHREEspine"
set pairwiseDir = pairwise.$target.$q
set tSizes = $target.chrom.sizes
set qSizes = $q.chrom.sizes
set tGenome = $target.2bit
set qGenome = $q.2bit
#set minMatch = 0.7

# merge chains
foreach tChrom (`cat $tSizes | cut -f1`)
    foreach qChrom (`cat $qSizes | cut -f1`)
        if (-d $pairwiseDir/$tChrom/chainingOutput/$qChrom) then
            find $pairwiseDir/$tChrom/chainingOutput/$qChrom -name '*.chain' -print0 | xargs -0 cat > $pairwiseDir/$tChrom/$tChrom.$qChrom.merge.chain
        endif
    end
    find $pairwiseDir/$tChrom -name '*.chain' -print0 | xargs -0 cat > $pairwiseDir/$tChrom.merge.chain
end

# merge chains (cont.) and net
#find $pairwiseDir -name '*.chain' -print0 | xargs -0 cat | $chainMergeSort > mergedChains/$target.$q.merged.chain
$chainMergeSort $pairwiseDir/*.chain > mergedChains/$target.$q.merged.chain
$chainSort mergedChains/$target.$q.merged.chain mergedChains/$target.$q.sorted.chain
$chainPreNet -inclHap mergedChains/$target.$q.sorted.chain $tSizes $qSizes nets/$target.$q.chain
$chainNet -inclHap nets/$target.$q.chain $tSizes $qSizes stdout /dev/null | $netSyntenic stdin nets/$target.$q.syntenicNettedChain.net
$netToAxt nets/$target.$q.syntenicNettedChain.net nets/$target.$q.chain $tGenome $qGenome nets/$target.$q.chaining.FINAL.axt
$axtToMaf -tPrefix=$target. -qPrefix=$q. nets/$target.$q.chaining.FINAL.axt $tSizes $qSizes nets/$target.$q.chaining.FINAL.maf

# generate liftover chain
$netChainSubset -verbose=0 nets/$target.$q.syntenicNettedChain.net nets/$target.$q.chain stdout \
| $chainStitchId stdin stdout | gzip -c > $target.To.$q.over.chain.gz

# do liftover
#$lift -minMatch=$minMatch inFile.bed $target.To.$q.over.chain.gz outFile.bed out.err

echo DONE
