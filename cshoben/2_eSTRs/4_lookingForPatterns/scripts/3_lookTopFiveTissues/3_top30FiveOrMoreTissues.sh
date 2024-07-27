#!/bin/bash

 cat top30PercentageTissuesHipstr.txt | sort -k1 | tr " " "\t" | cut -f 1 | uniq -c | tr " " "\t" | awk '{if ($1 >= 5) print}' > patternsFiles/fiveOrMoreTissuesPercentageTop30Hipstr.txt

 cat top30PercentageTissuesTotalEstr.txt | sort -k1 | tr " " "\t" | cut -f 1 | uniq -c | tr " " "\t" | awk '{if ($1 >= 5) print}' > patternsFiles/fiveOrMoreTissuesPercentageTop30TotalEstr.txt
