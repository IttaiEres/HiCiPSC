for FILE in 10000 25000 50000 100000 250000 500000; do
bedtools intersect -c -a ${FILE}.domains.ortho.panTro6 -b ../PT6_ortho_genes.txt > ${FILE}.ortho.gene.overlap
done
