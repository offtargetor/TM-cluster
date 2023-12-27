#/use/bin/bash
###Useage:
###sh TM-cluster.sh gene-sort-list structurepath out value cluster
###
###gene-sort-list:The file sorted by genes length from largest to smallest.
###structurepath:The path of structure of genes
###out:The file storing TM-score 
###value:The value of Classification threshold(for example:0.7)
###cluster:The out file of cluster.
list=$1
structurepath=$2
out=$3
cluster=$5
rm $out
cat $list|while read line
do
	ref=$line
	cat $list|while read line
	do
		USalign $structurepath/$ref.pdb $structurepath/$line.pdb >$ref.$line.out
		tmscore=`less $ref.$line.out |grep TM-score|grep Structure_1 |awk '{print $2}'`
		rm $ref.$line.out
		echo "$ref	$line	$tmscore" >>$out
	done
done
less $out |sort -k 1,1 -k 3,3g >$out.sort

rm $cluster
cat $list|while read line
do
        name=`echo $line|awk '{print $1}'`
        grep "^$name" apobec.msta.sort |awk -v value=$4 '{if($3>value){print $0}}' >>$cluster
done
less $cluster |awk 'BEGIN{i=1;}{if(a!=$1){printf "\n"i"\t"$2;a=$1;i++}else{printf "\t"$2}}' >$cluster.sort
