for tree in `cat $1`
do
	grep $tree $2 
done
