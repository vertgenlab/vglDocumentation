# VisualizeWF Manual

VisualizeWF produces a png file of allele freuqencies from simulateWrightFisher tsv output.

**Usage #1 (At directory containing the R file, have the file executable):**
`Rscript visualizeWF.R input_name.tsv output_name.png`

**Usage #2 - Use it as command line:**
Full instruction[https://dev.to/mpjdem/r-scripts-as-command-line-tools-2k6c]
Step 1. Make visualizeWF.R executable
`chmod +x visualizeWF.R`
Step 2. Make a symbolic link to bin
`ln -s path_to_program/visualizeWF.R /usr/local/bin/visualizeWF`
Now you can run `visualizeWF` anywhere as long as you have `/usr/local/bin/` in your `$PATH`
`visualizeWF input_name.tsv output_name.png`