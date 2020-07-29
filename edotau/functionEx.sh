#!/bin/sh
set -e
function hello {
	echo "hello" $1
}
function bwa {
	echo "align sequence $1 $2"
}

bwa read1 read2
hello eric
