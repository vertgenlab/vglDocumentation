this is not the executable but documentation of the code used. 

$ cat hg19.hipstr_reference.bed | cut -f 7 | tr "/" "\n" | sort | uniq -c | sort -k2 > collapseHg19.hipstr_reference.txt
