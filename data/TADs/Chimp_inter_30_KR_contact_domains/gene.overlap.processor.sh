for FILE in 5000 10000 25000 50000 100000 250000 500000; do
bedtools intersect -c -a ${FILE}.domains.ortho.panTro5 -b ../chimp_ortho_genes.txt > ${FILE}.ortho.gene.overlap
done
