import sys

if len(sys.argv) < 3:
	print "Provide ID file (.txt) and fasta file (.fasta)"
else:
	f = open(sys.argv[1],'r')
	db = open(sys.argv[2],'r')
	out = open(sys.argv[1][:-4]+".fasta",'w')

	IDlist = []
	for line in f:
		IDlist.append(line[:-1])

	for line in db:
		if line[0] == ">":
			sid = line.split('|')[1]
		if sid not in IDlist:
			out.write(line)
