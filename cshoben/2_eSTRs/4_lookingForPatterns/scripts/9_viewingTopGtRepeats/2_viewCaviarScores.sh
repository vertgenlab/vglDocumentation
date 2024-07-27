#!/bin/bash

cat chr11297578grabMasterLineAllTissues.txt | awk 'BEGIN{FS=" "}{print $1, $2, $3, $8, $9, $26, $31, $32, $33}'

cat chr3_9883164grabMasterLineAllTissues.txt | awk 'BEGIN{FS=" "}{print $1, $2, $3, $8, $9, $26, $31, $32, $33}'

