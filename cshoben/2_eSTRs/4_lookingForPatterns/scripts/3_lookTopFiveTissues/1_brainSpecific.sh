#!/bin/bash

cat top30PercentageTissuesHipstr.txt |\
       	sort -k1 |\
       	awk '{ if ($5 == "Brain-Caudate" || $5 == "Brain-Cerebellum") print}' \
	> brainTop30PercentageTissuesHisptr.txt

cat brainTop30PercentageTissuesHisptr.txt |\
       	tr " " "\t" |\
       	cut -f 1 |\
       	uniq -c |\
       	sort -k1\
       	> sortUniqBrainTop30PercentageTissuesHisptr.txt

cat top30PercentageTissuesTotalEstr.txt |\
       	sort -k1 |\
       	awk '{ if ($5 == "Brain-Caudate" || $5 == "Brain-Cerebellum") print}' \
	> brainTop30PercentageTissuesTotalEstr.txt

cat brainTop30PercentageTissuesTotalEstr.txt |\
       	tr " " "\t" |\
       	cut -f 1 |\
       	uniq -c |\
       	sort -k1\
       	> sortUniqBrainTop30PercentageTissuesTotalEstr.txt
