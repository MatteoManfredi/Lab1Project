if [ ! -f "output.txt" ]
then
	echo "The file output.txt is not in this folder"
else if [ ! -f "evaluate_confusion_matrix.py" ]
then
	echo "The file evaluate_confusion_matrix.py is not in this folder"
else

	for i in {-4..+2}; do
		e="1e$i"
		echo "Statistics for e-value = $e"
		stat=`awk 'BEGIN{p=323;n=556653;e='$e';tp=0;fp=0}{if($0~/\|P\|/&&$1<e){tp++}else{if($0~/\|N\|/&&$1<e){fp++}}}END{print(tp,fp,p-tp,n-fp)}' output.txt`
		echo $stat
		tp=`echo $stat | cut -f 1`
		fp=`echo $stat | cut -f 2`
		fn=`echo $stat | cut -f 3`
		tn=`echo $stat | cut -f 4`
		python evaluate_confusion_matrix.py $tp $fp $fn $tn
		echo
	done
fi
fi
