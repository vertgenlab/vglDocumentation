Bed files included on the cluster:
manipulatedMouseSimpleRepGenBrow.bed
mm10StrUcscGBrowser.bed
mouseSimpleRepeatsGenomeBrowser_mm10.bed

This was attempted a few different ways. The final saved version requires a pseudocount to be added to all wig values. This is important for the division used downstream to determine the 'fold change' between tissues as we can not divide by zero. Reference my tandemRepeatMethods google doc for details on past attempts. 
