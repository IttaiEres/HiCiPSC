for FILE in 5000 10000 25000 50000 100000 250000 500000; do
bedtools genomecov -i ${FILE}.domains.ortho.hg38 -g ../hg38.chrom.sizes > ${FILE}.ortho.genome.coverage
done

