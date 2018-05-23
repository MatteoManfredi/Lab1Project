if [ ! -f "tabularResults.csv" ]
then
	echo "The file tabularResults.csv is not in this folder"
else


	tail -n +2 tabularResults.csv | sed s/\"//g | awk 'BEGIN{FS=","}{if($4 in a) {} else {print(">"$1":"$2);print($4)}; a[$4] = 1}' > training_set.fasta

	awk 'BEGIN{FS=">"}{if ($2) print($2)}' training_set.fasta > training_set.txt

	echo "Number of chains used:"
	grep "^>" training_set.fasta | wc -l
	echo
	echo "Use the generated file training_set.txt as input on"
	echo "	http://www.ebi.ac.uk/msd-srv/ssm/"
	echo "(Launch PDBeFold -> Multiple -> List of PDB Codes)"
	echo
	echo "Download from there the files match.dat, send.rasmol and fasta.seq"
	echo
	echo "From Uniprot, search all the positive sequences, then:"
	echo "	Download them in fasta format in a file called all_positive_set.fasta"
	echo "	Download them in list format in a file called all_negative_set.txt" 
	echo
	echo "Once you made sure that the files fasta.seq, remove_fasta.py, SwissProt.fasta, all_positive_set.fasta and all_negative_set.txt are all in this folder, run the script workflow.sh"
fi
