for FILE in 5000 10000 25000 50000 100000 250000 500000;
do
	cut -f 1-3,8 ${FILE}_blocks | tail -n +2 > ${FILE}.domains
	HClift.sh C ${FILE}.domains #Get LO of domains, will take boundaries from here

	#Prep boundary files from the lifted-over domain files (both coordinates). Because arrowhead identifies domains, and not boundaries themselves here, makes most sense to LO domains and then pull boundaries from there (could also check against LO of original domain boundaries, but high overlap when previously checked).
	awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${FILE}.domains.ortho.hg38 > ${FILE}.LO.boundaries.hg38
	awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${FILE}.domains.ortho.hg38 >> ${FILE}.LO.boundaries.hg38

	awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${FILE}.domains.ortho.panTro5 > ${FILE}.LO.boundaries.panTro5
	awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${FILE}.domains.ortho.panTro5 >> ${FILE}.LO.boundaries.panTro5

	#Sort all output files so multiintersectbed will work on them:
	sort -k1,1 -k2,2n ${FILE}.domains.ortho.hg38 > ${FILE}.domains.ortho.sorted.hg38
	sort -k1,1 -k2,2n ${FILE}.domains.ortho.panTro5 > ${FILE}.domains.ortho.sorted.panTro5
	sort -k1,1 -k2,2n ${FILE}.LO.boundaries.hg38 > ${FILE}.LO.boundaries.sorted.hg38
	sort -k1,1 -k2,2n ${FILE}.LO.boundaries.panTro5 > ${FILE}.LO.boundaries.sorted.panTro5
done
