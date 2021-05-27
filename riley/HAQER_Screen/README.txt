HAQER SCREEN PROTOCOL

1. Multiple alignment using multiZ. Start with pairwise alignments (maf format from lastz pipeline, placed in a directory called pairwise.) setup.csh prepares associated files required for the screen and runMultiz.csh executes the multiple alignment.
2. Multiple alignment in maf format is placed in the output directory. Run the script runMafToFaBatch.csh to convert to fa format. 
3. MultiFa is placed in the rawFa directory. Run runBatchPrimateRecon.csh to produce reconstruction alignments. 
4. Next output is in the directory 'ReconAln'. Use splitHumanHCAfromRecon.csh. 
5.Output from last step is in findFastFiles. Run runFaFindFastBatch.csh.
6. Next output is large, but temporary. Move to findFastFiles. Run runbedFilterBatch.csh and then delete the bed files in this directory.
7. Next output is in Filtered. Run runBedMergeBatch.csh to produce HAQERs or runBedFilterBatch.csh to apply additional filtering.
8. The output bed from the last step can be catted into the final file.
9. To annotation epigenomic intersections, use the output bed to run runEpigenomicOverlap.csh.