for FILE in 10000 25000 50000 100000 250000 500000; do
bedtools intersect -c -a ${FILE}.domains -b ../PT6_ortho_genes.txt > ${FILE}.gene.overlap #Was initially done on refGene modified final file, but discrepancies huge
done
