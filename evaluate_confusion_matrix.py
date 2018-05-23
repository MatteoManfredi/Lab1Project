#overall accuracy and matthew correlation index

import math
import sys

if len(sys.argv) < 5:
	print "Provide 4 values (TP, FP, FN, TN)"
else:
	tp = int(sys.argv[1])
	fp = int(sys.argv[2])
	fn = int(sys.argv[3])
	tn = int(sys.argv[4])

	p = tp+fn
	n = fp+tn

	t = tp+tn
	f = fp+fn

	pp = tp+fp
	pn = tn+fn

	a = p+n


	tpr = 1.0*tp/p
	tnr = 1.0*tn/n
	ppv = 1.0*tp/pp
	npv = 1.0*tn/pn
	fnr = 1.0*fn/p
	fpr = 1.0*fp/n
	fdr = 1.0*fp/pp
	forate = 1.0*fn/pn
	acc = 1.0*t/a
	f1 = 2*tp / (p+pp)
	mcc = (tp*tn - fp*fn) / math.sqrt(pp*p*pn*n)
	bm = tpr+tnr-1
	mk = ppv+npv-1

	print "Accuracy = ", acc
	print "Matthew Correlation Coefficient =", mcc
