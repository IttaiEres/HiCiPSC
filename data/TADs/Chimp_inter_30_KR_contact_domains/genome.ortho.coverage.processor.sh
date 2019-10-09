for FILE in 5000 10000 25000 50000 100000 250000 500000; do
bedtools genomecov -i ${FILE}.domains.ortho.panTro5 -g ../panTro5.chrom.sizes > ${FILE}.ortho.genome.coverage
done
