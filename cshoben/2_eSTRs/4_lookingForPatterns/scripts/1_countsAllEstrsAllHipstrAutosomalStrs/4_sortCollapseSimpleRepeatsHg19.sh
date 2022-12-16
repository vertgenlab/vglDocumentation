#!/bin/bash

zcat simpleRepeatsHg19.gz | cut -f 17 | grep -v sequence | sort | uniq -c | sort -k2 > simpleRepeatsHg19CollapsedSorted.txt
