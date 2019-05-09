for RES in 5000 10000 25000 50000 100000 250000 500000; do
	bedtools intersect -c -f 0.9 -r -a Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 -b Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 > overlaps/${RES}.HC.bedtoolsc.hg38
	bedtools intersect -c -f 0.9 -r -a Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 -b Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 > overlaps/${RES}.CH.bedtoolsc.hg38
	bedtools intersect -c -f 0.9 -r -a Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 -b Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 > overlaps/${RES}.HC.bedtoolsc.panTro5
	bedtools intersect -c -f 0.9 -r -a Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 -b Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 > overlaps/${RES}.CH.bedtoolsc.panTro5

	bedtools intersect -c -f 0.9 -r -a Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.hg38 -b PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 > overlaps/${RES}.HC.bedtoolsc.hg38.pt6
	bedtools intersect -c -f 0.9 -r -a PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 -b Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.hg38 > overlaps/${RES}.CH.bedtoolsc.hg38.pt6
	bedtools intersect -c -f 0.9 -r -a Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.panTro6 -b PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro6 > overlaps/${RES}.HC.bedtoolsc.panTro6
	bedtools intersect -c -f 0.9 -r -a PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro6 -b Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.panTro6 > overlaps/${RES}.CH.bedtoolsc.panTro6


done


