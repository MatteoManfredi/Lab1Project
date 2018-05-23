if [ ! -f "fasta.seq" ]
then
	echo "The file fasta.seq is not in this folder"
else if [ ! -f "all_positive_set.fasta" ]
then
	echo "The file all_positive_set.fasta is not in this folder"
else if [ ! -f "remove_fasta.py" ]
then
	echo "The file remove_fasta.py is not in this folder"
else if [ ! -f "all_negative_set.txt" ]
then
	echo "The file all_negative_set.txt is not in this folder"
else if [ ! -f "SwissProt.fasta" ]
then
	echo "The file SwissProt.fasta is not in this folder"
else

	hmmbuild model.hmm fasta.seq
	echo "Model built"
	echo

	echo "Start generating positive set"
	formatdb -i training_set.fasta
	blastall -p blastp -i all_positive_set.fasta -d training_set.fasta -m 8 -o all_positive_set.blast
	sort -nrk 3 all_positive_set.blast | awk '{if ($3 > 90.0) print $0}' | cut -f 1 | cut -d "|" -f 2 > positive_set.txt
	python remove_fasta.py positive_set.txt all_positive_set.fasta
	echo "Positive set generated"
	echo

	echo "Start generating negative set"
	python remove_fasta.py all_negative_set.txt SwissProt.fasta
	echo "Negative set generated"
	echo

	echo "Start generating complete benchmark set"
	cat <(sed -e 's/sp|//' positive_set.fasta | awk -F "|" '{if ($1 ~ /^>/) {print $1 "|P|"} else {print $1}}') <(sed -e 's/sp|//' all_negative_set.fasta | awk -F "|" '{if ($1 ~ /^>/) {print $1 "|N|"} else {print $1}}') > all_set.fasta
	echo "Complete benchmark set generated"
	echo

	echo "Start running hmmsearch"
	hmmsearch --noali --max -E 1000 -o all_set_out.txt model.hmm all_set.fasta
	echo "hmmsearch completed"
	echo

	tail -n +17 all_set_out.txt | awk '{if ($0 ~ /^$/) {exit 0} else {print $0}}' > output.txt

	echo
	echo "Initial number of positive sequences:"
	grep "^>" all_positive_set.fasta | wc -l
	echo "Number of removed sequences:"
	cat positive_set.txt | sort -u | wc -l
	echo "Final number of positive sequences:"
	grep "^>" positive_set.fasta | wc -l
	echo
	echo "Final number of negative sequences:"
	grep "^>" all_negative_set.fasta | wc -l
	echo
	echo "Total number of sequences:"
	grep "^>" all_set.fasta | wc -l
	echo
	echo
	echo "Final output printed in file output.txt"
	echo
fi
fi
fi
fi
fi
