#!/bin/bash

cat top30PercentageTissuesTotalEstr.txt | awk '{ if ($5 == "Cells-Transformedfibroblasts") print}' > patternsFiles/FibroblastsTop30PercentageTissuesTotalEstr.txt

cat top30PercentageTissuesHipstr.txt | awk '{ if ($5 == "Cells-Transformedfibroblasts") print}' > patternsFiles/FibroblastsTop30PercentageTissuesHipstr.txt
