for FILE in 10000 25000 50000 100000 250000 500000; do
sort -k1,1 -k2,2n ${FILE}.domains > ${FILE}.domains.sorted
bedtools genomecov -i ${FILE}.domains.sorted -g ../panTro6.chrom.sizes > ${FILE}.genome.coverage
done

