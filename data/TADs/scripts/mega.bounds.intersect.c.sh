for FILE in 5000 10000 25000 50000 100000 250000 500000; do
		
		bedtools intersect -c -a Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 -b Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 > overlaps/${FILE}.boundaries.overlap.H2C.hg38
		bedtools intersect -c -a Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 -b Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 > overlaps/${FILE}.boundaries.overlap.C2H.hg38
		
		bedtools intersect -c -a Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro5 -b Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro5 > overlaps/${FILE}.boundaries.overlap.H2C.panTro5
		bedtools intersect -c -a Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro5 -b Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro5 > overlaps/${FILE}.boundaries.overlap.C2H.panTro5
		
		bedtools intersect -c -a Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.sorted.hg38 -b PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 > overlaps/${FILE}.boundaries.overlap.H2C.hg38.pt6
		bedtools intersect -c -a PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 -b Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.sorted.hg38 > overlaps/${FILE}.boundaries.overlap.C2H.hg38.pt6
		
		bedtools intersect -c -a Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.sorted.panTro6 -b PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro6 > overlaps/${FILE}.boundaries.overlap.H2C.panTro6
		bedtools intersect -c -a PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro6 -b Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.sorted.panTro6 > overlaps/${FILE}.boundaries.overlap.C2H.panTro6
		
		
done

