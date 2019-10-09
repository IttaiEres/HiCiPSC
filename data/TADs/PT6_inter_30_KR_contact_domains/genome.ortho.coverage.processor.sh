for FILE in 10000 25000 50000 100000 250000 500000; do
sort -k1,1 -k2,2n ${FILE}.domains.ortho.panTro6 > ${FILE}.domains.ortho.panTro6.sorted
bedtools genomecov -i ${FILE}.domains.ortho.panTro6.sorted -g ../panTro6.chrom.sizes > ${FILE}.ortho.genome.coverage
done

