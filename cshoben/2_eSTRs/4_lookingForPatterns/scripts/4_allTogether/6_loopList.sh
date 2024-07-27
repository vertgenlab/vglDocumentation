#!/bin/bash

cat bothFRTempBrain-CerebellumSigCaviar.txt | awk '{ print $2}' > loopListBothFRSigCaviarBrain-Cerebellum.txt

cat bothFRTempCells-TransformedfibroblastsSigCaviar.txt | awk '{print $2}' > loopListBothFRSigCaviarCells-Transformedfibroblasts.txt

cat Brain-CerebellumEstrSigCaviarCountBrainCountSigTissues.txt | awk '{print $1}' > loopListBrain-CerebellumEstrSigCaviarCountBrainCountSigTissues.txt

cat Cells-TransformedfibroblastsEstrSigCaviarCountSigTissuesCount.txt | awk '{print $1}' > loopListCells-TransformedfibroblastsEstrSigCaviarCountSigTissuesCount.txt
