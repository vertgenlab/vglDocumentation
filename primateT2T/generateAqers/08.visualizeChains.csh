#!/bin/csh -evf

# set

# axtToPsl
set axtToPsl = /hpc/group/vertgenlab/cl454/bin/x86_64/axtToPsl

# bigChain
wget https://genome.ucsc.edu/goldenPath/help/examples/bigChain.as
wget https://genome.ucsc.edu/goldenPath/help/examples/bigLink.as
set netChainSubset = /hpc/group/vertgenlab/cl454/bin/x86_64/netChainSubset
set hgLoadChain = /hpc/group/vertgenlab/cl454/bin/x86_64/hgLoadChain
set bedToBigBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed

# dir
set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/bigChains

# target
set target = "humanT2T"
set targetDb = "hs1"
set tSizes = $tmp/$target.chrom.sizes

# query
#set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "orangutanT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt" "orangutanT2Talt" "humanGapped" "chimpGapped" "gorillaGapped" "bonoboGapped" "orangutanGapped" "HG002mat" "HG002pat" "YAOmat" "YAOpat" "Han1" "CN1mat" "CN1pat")
set queries = ("chimpT2Tpri" "gorillaT2Tpri" "bonoboT2Tpri" "orangutanT2Tpri" "borangutanT2Tpri" "gibbonT2Tpri" "chimpT2Talt" "gorillaT2Talt" "bonoboT2Talt" "orangutanT2Talt" "borangutanT2Talt" "gibbonT2Talt")

# execute
foreach q ($queries)
        echo working on $q
        set qSizes = $tmp/$q.chrom.sizes

        # axtToPsl
        $axtToPsl $tmp/nets/$target.$q.chaining.refilter.FINAL.axt $tSizes $qSizes $tmp/nets/pairwise.$target.$q.psl

        # bigChain (wholeChains)
        # -wholeChains - Write entire chain references by net, don't split when a high-level net is encoundered.  This is useful when nets have been filtered.
        # -skipMissing - skip chains that are not found instead of generating an error.  Useful if chains have been filtered.
        #$netChainSubset -wholeChains -skipMissing $tmp/nets/$target.$q.syntenicNettedChain.net $tmp/nets/$target.$q.chain $tmp/bigChains/$target.$q.inNet.chain
        $netChainSubset -wholeChains -skipMissing $tmp/nets/$target.$q.syntenicNettedChain.refilter.net $tmp/nets/$target.$q.refilter.chain $tmp/bigChains/$target.$q.inNet.refilter.chain
        # generate the chain.tab and link.tab files needed to create the bigChain file.
        # chain.tab and link.tab will be overwritten for each new chain
        #$hgLoadChain -noBin -test $targetDb bigChain $tmp/bigChains/$target.$q.inNet.chain
	$hgLoadChain -noBin -test $targetDb bigChain $tmp/bigChains/$target.$q.inNet.refilter.chain
        # generate bigChain file
        #sed 's/\.000000//' chain.tab | awk 'BEGIN {OFS="\t"} {print $2, $4, $5, $11, 1000, $8, $3, $6, $7, $9, $10, $1}' > $tmp/bigChains/$target.$q.bigChain
        sed 's/\.000000//' chain.tab | awk 'BEGIN {OFS="\t"} {print $2, $4, $5, $11, 1000, $8, $3, $6, $7, $9, $10, $1}' > $tmp/bigChains/$target.$q.refilter.bigChain
        #$bedToBigBed -type=bed6+6 -as=bigChain.as -tab $tmp/bigChains/$target.$q.bigChain $tSizes $tmp/bigChains/$target.$q.bigChain.bb
        $bedToBigBed -type=bed6+6 -as=bigChain.as -tab $tmp/bigChains/$target.$q.refilter.bigChain $tSizes $tmp/bigChains/$target.$q.refilter.bigChain.bb
        # generate binary indexed link file to accompany bigChain file for display in the Genome Browser
        #awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $5, $4}' link.tab | sort -k1,1 -k2,2n > $tmp/bigChains/$target.$q.bigChain.bigLink
	awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $5, $4}' link.tab | sort -k1,1 -k2,2n > $tmp/bigChains/$target.$q.refilter.bigChain.bigLink 
	#$bedToBigBed -type=bed4+1 -as=bigLink.as -tab $tmp/bigChains/$target.$q.bigChain.bigLink $tSizes $tmp/bigChains/$target.$q.bigChain.link.bb
        $bedToBigBed -type=bed4+1 -as=bigLink.as -tab $tmp/bigChains/$target.$q.refilter.bigChain.bigLink $tSizes $tmp/bigChains/$target.$q.refilter.bigChain.link.bb
	# remove intermediate files (anything that's not bigChain.bb or bigChain.link.bb)
        #rm $tmp/bigChains/$target.$q.bigChain
        #rm $tmp/bigChains/$target.$q.bigChain.bigLink
        rm $tmp/bigChains/$target.$q.refilter.bigChain
        rm $tmp/bigChains/$target.$q.refilter.bigChain.bigLink

	# bigChain (splitChains)
	# -splitOnInsert - Split chain when get an insertion of another chain
	#$netChainSubset -splitOnInsert $tmp/nets/$target.$q.syntenicNettedChain.net $tmp/nets/$target.$q.chain $tmp/bigChains/$target.$q.splitChains.inNet.chain
        #$hgLoadChain -noBin -test $targetDb bigChain $tmp/bigChains/$target.$q.splitChains.inNet.chain
        #sed 's/\.000000//' chain.tab | awk 'BEGIN {OFS="\t"} {print $2, $4, $5, $11, 1000, $8, $3, $6, $7, $9, $10, $1}' > $tmp/bigChains/$target.$q.splitChains.bigChain
	#$bedToBigBed -type=bed6+6 -as=bigChain.as -tab $tmp/bigChains/$target.$q.splitChains.bigChain $tSizes $tmp/bigChains/$target.$q.splitChains.bigChain.bb
        #awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $5, $4}' link.tab | sort -k1,1 -k2,2n > $tmp/bigChains/$target.$q.splitChains.bigChain.bigLink
        #$bedToBigBed -type=bed4+1 -as=bigLink.as -tab $tmp/bigChains/$target.$q.splitChains.bigChain.bigLink $tSizes $tmp/bigChains/$target.$q.splitChains.bigChain.link.bb
        #rm $tmp/bigChains/$target.$q.splitChains.bigChain
        #rm $tmp/bigChains/$target.$q.splitChains.bigChain.bigLink
	$netChainSubset -splitOnInsert $tmp/nets/$target.$q.syntenicNettedChain.refilter.net $tmp/nets/$target.$q.refilter.chain $tmp/bigChains/$target.$q.splitChains.inNet.refilter.chain
        $hgLoadChain -noBin -test $targetDb bigChain $tmp/bigChains/$target.$q.splitChains.inNet.refilter.chain
        sed 's/\.000000//' chain.tab | awk 'BEGIN {OFS="\t"} {print $2, $4, $5, $11, 1000, $8, $3, $6, $7, $9, $10, $1}' > $tmp/bigChains/$target.$q.splitChains.refilter.bigChain
        $bedToBigBed -type=bed6+6 -as=bigChain.as -tab $tmp/bigChains/$target.$q.splitChains.refilter.bigChain $tSizes $tmp/bigChains/$target.$q.splitChains.refilter.bigChain.bb
        awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $5, $4}' link.tab | sort -k1,1 -k2,2n > $tmp/bigChains/$target.$q.splitChains.refilter.bigChain.bigLink
        $bedToBigBed -type=bed4+1 -as=bigLink.as -tab $tmp/bigChains/$target.$q.splitChains.refilter.bigChain.bigLink $tSizes $tmp/bigChains/$target.$q.splitChains.refilter.bigChain.link.bb
        rm $tmp/bigChains/$target.$q.splitChains.refilter.bigChain
        rm $tmp/bigChains/$target.$q.splitChains.refilter.bigChain.bigLink

end

# remove intermediate files
rm chain.tab
rm link.tab
rm bigChain.as
rm bigLink.as

echo DONE
