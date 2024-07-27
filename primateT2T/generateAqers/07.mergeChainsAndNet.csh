#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way
#set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "orangutanT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt" "orangutanT2Talt" "humanGapped" "chimpGapped" "gorillaGapped" "bonoboGapped" "orangutanGapped")
#set queries = ("HG002mat" "HG002pat" "YAOmat" "YAOpat" "Han1" "CN1mat" "CN1pat")
set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "orangutanT2Tpri" "borangutanT2Tpri" "gibbonT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt" "orangutanT2Talt" "borangutanT2Talt" "gibbonT2Talt")
set target = "humanT2T"
set tSizes = $tmp/$target.chrom.sizes
mkdir -p $tmp/mergedChains
mkdir -p $tmp/nets
mkdir -p $tmp/bigChains
set chainSort =  /hpc/group/vertgenlab/cl454/bin/x86_64/chainSort
set chainPreNet = /hpc/group/vertgenlab/cl454/bin/x86_64/chainPreNet
set chainNet = /hpc/group/vertgenlab/cl454/bin/x86_64/chainNet
set chainFilter = /hpc/group/vertgenlab/cl454/bin/x86_64/chainFilter
set netChainSubset = /hpc/group/vertgenlab/cl454/bin/x86_64/netChainSubset
set netSyntenic = /hpc/group/vertgenlab/cl454/bin/x86_64/netSyntenic
set netToAxt = /hpc/group/vertgenlab/cl454/bin/x86_64/netToAxt
set axtToMaf = /hpc/group/vertgenlab/cl454/bin/x86_64/axtToMaf
set chainMergeSort = /hpc/group/vertgenlab/cl454/bin/x86_64/chainMergeSort
set tGenome = $tmp/$target.2bit

foreach q ($queries)
        set pairwiseDir = $tmp/alignments/pairwise.$target.$q
        set qSizes = $tmp/$q.chrom.sizes
        set qGenome = $tmp/$q.2bit
        echo working on $q
        foreach tChrom (`cat $tSizes | cut -f1`)
                foreach qChrom (`cat $qSizes | cut -f1`)
                        if (-d $pairwiseDir/$tChrom/chainingOutput/$qChrom) then
                                $chainMergeSort $pairwiseDir/$tChrom/chainingOutput/$qChrom/*.chain > $pairwiseDir/$tChrom/$tChrom.$qChrom.merge.chain
                        endif
                end
                $chainMergeSort $pairwiseDir/$tChrom/*.chain > $pairwiseDir/$tChrom.merge.chain
        end
        
       	$chainMergeSort $pairwiseDir/*.chain > $tmp/mergedChains/$target.$q.merged.chain
        $chainSort $tmp/mergedChains/$target.$q.merged.chain $tmp/mergedChains/$target.$q.sorted.chain
        $chainPreNet -inclHap $tmp/mergedChains/$target.$q.sorted.chain $tSizes $qSizes $tmp/nets/$target.$q.chain
        $chainNet -inclHap $tmp/nets/$target.$q.chain $tSizes $qSizes stdout /dev/null | $netSyntenic stdin $tmp/nets/$target.$q.syntenicNettedChain.net
	$netChainSubset -splitOnInsert $tmp/nets/$target.$q.syntenicNettedChain.net $tmp/nets/$target.$q.chain $tmp/bigChains/$target.$q.splitChains.inNet.chain
        
	$chainFilter -minScore=60000 $tmp/bigChains/$target.$q.splitChains.inNet.chain \
        | $chainMergeSort stdin \
        | $chainSort stdin $tmp/nets/$target.$q.refilter.chain
        $chainNet -inclHap $tmp/nets/$target.$q.refilter.chain $tSizes $qSizes stdout /dev/null \
        | $netSyntenic stdin $tmp/nets/$target.$q.syntenicNettedChain.refilter.net 
	$netToAxt $tmp/nets/$target.$q.syntenicNettedChain.refilter.net $tmp/nets/$target.$q.refilter.chain $tGenome $qGenome $tmp/nets/$target.$q.chaining.refilter.FINAL.axt
        $axtToMaf -tPrefix=$target. -qPrefix=$q. $tmp/nets/$target.$q.chaining.refilter.FINAL.axt $tSizes $qSizes $tmp/nets/$target.$q.chaining.refilter.FINAL.maf
end

echo DONE
