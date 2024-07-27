#!/bin/bash

cat groupedHipstrAllSigEstrLabelTissue.txt | sort -k1 | tr " " "\t" | cut -f 1 | uniq -c | tr " " "\t" | awk '{ if ($1 >= 5) print}' > patternsFiles/commonFiveOrMoreTissuesHipstr.txt


cat groupedTotalAllSigEstrLabelTissue.txt | sort -k1 | tr " " "\t" | cut -f 1 | uniq -c | tr " " "\t" | awk '{ if ($1 >= 5) print}' > patternsFiles/commonFiveOrMoreTissuesTotalEstr.txt
