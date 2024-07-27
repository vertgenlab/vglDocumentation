#!/bin/bash

diff onlyUniqSeqAllEstrStudied.txt onlyUniqSeqHipstrReference.txt | grep "<" >> seqDiffInAllEstr.txt
