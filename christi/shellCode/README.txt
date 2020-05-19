shellCode contains codes written to function inside the Duke computing cluster. 
 
 array.sh files are for running large numbers of similar commands and can be run with "sbatch -a 1-n%p (array.sh)" where n is the number of lines in a corresponding text file and p is the percentage of the commands to run at once.
 
 The corresponding txt file will be called by that array.sh file and needs to contain one command per line as you would write them in a wrap. 
