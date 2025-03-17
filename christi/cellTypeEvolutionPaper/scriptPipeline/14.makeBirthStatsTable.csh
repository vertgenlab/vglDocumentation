#!/bin/bash -ev

echo "CellType	NodeX	Node0	Node1	Node2	Node3	Node4	Node5	Node6	Node7	Node8	Node9	Node10	Node11	Node12	Node13	Node14	Node15	Node16	Node17" > birthTable.medium.tsv


paste <(cut -f1 ../atlasStatsMerged.txt) <(cut -f5 nodeX.stats.fraction.txt) > testing_tmp.txt

for n in {0..17}
do
paste testing_tmp.txt <(cut -f5 node$n.stats.fraction.txt) >> testing_tmp2.txt
mv testing_tmp2.txt testing_tmp.txt
done
cat testing_tmp.txt >> birthTable.medium.tsv

awk '{if (NR==1) $2="NodeH_3"; else $2=$2+$3+$4+$5+$6; print $1"\t"$2"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17"\t"$18"\t"$19"\t"$20}' birthTable.medium.tsv > birthTable.combined0_3.medium.tsv

