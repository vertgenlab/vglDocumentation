#!/bin/csh -evf

set netChainSubset = /hpc/group/vertgenlab/cl454/bin/x86_64/netChainSubset
set chainStitchId = /hpc/group/vertgenlab/cl454/bin/x86_64/chainStitchId
set chainSwap = /hpc/group/vertgenlab/cl454/bin/x86_64/chainSwap

set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/liftOver

set target = "humanT2T"
set targetDb = "hs1"
set tSizes = $tmp/$target.chrom.sizes

set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "orangutanT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt" "orangutanT2Talt")

foreach q ($queries)
        echo working on $q
        set qSizes = $tmp/$q.chrom.sizes
        $netChainSubset -verbose=0 $tmp/nets/$target.$q.syntenicNettedChain.refilter.net $tmp/nets/$target.$q.refilter.chain stdout \
        | $chainStitchId stdin stdout | gzip -c > $tmp/liftOver/$target.$q.splitChains.inNet.refilter.over.chain.gz
        $chainSwap $tmp/liftOver/$target.$q.splitChains.inNet.refilter.over.chain.gz $tmp/liftOver/$q.$target.over.chain
end

gzip $tmp/liftOver/*.chain

echo DONE
