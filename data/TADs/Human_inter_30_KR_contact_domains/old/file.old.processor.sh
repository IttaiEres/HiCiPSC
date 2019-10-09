for FILE in 10000 25000 50000 100000 500000;
do
cut -f 1-3 ${FILE}_blocks | tail -n +2 > ${FILE}.domains
hg38_PT5_lift.9.sh H ${FILE}.domains #Get LO of domains
SHIFT=$((${FILE}*3/2)) #For boundaries
awk -v var=SHIFT '{print $1 "\t" ($2-var) "\t" ($2+var)}' ${FILE}.domains > ${FILE}.bounds
awk -v var=SHIFT '{print $1 "\t" ($3-var) "\t" ($3+var)}' ${FILE}.domains >> ${FILE}.bounds
hg38_PT5_lift.9.sh H ${FILE}.bounds #Get LO of boundaries
done

