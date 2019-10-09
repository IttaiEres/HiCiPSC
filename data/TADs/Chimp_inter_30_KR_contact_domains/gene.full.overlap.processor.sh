for FILE in 5000 10000 25000 50000 100000 250000 500000; do
bedtools intersect -c -a ${FILE}.domains -b ../chimp_ortho_genes.txt > ${FILE}.gene.overlap #Initially I had done this on the c.refGene.final.bed files for each, but discrepancies were huge
done
