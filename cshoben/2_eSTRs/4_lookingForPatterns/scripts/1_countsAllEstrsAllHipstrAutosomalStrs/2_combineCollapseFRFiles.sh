#!/bin/bash

cat $1ForwardRepeat.txt $1ReverseRepeat.txt | sort | uniq -c | sort -k1 -g > $1FRCollapse.txt

