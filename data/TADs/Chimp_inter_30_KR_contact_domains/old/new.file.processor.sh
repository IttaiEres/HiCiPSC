for FILE in 10000 25000 50000 100000 250000 500000;
do
cut -f 1-3,8 ${FILE}_blocks | tail -n +2 > ${FILE}.domains
awk '{print $1 "\t" ($2-15000) "\t" ($2+15000) "\t" $4}' ${FILE}.domains > ${FILE}.boundaries
awk '{print $1 "\t" ($3-15000) "\t" ($3+15000) "\t" $4}' ${FILE}.domains >> ${FILE}.boundaries
HClift.sh C ${FILE}.domains #Get LO of domains
HClift.sh C ${FILE}.boundaries #Get LO of boundaries
done

