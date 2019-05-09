for RES in 5000 10000 25000 50000 100000 250000 500000; do
	bedtools closest -a Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 -b Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 > overlaps_rao_style/${RES}.HC.closest.hg38
	bedtools closest -a Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 -b Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 > overlaps_rao_style/${RES}.CH.closest.hg38
	bedtools closest -a Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 -b Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 > overlaps_rao_style/${RES}.HC.closest.panTro5
	bedtools closest -a Chimp_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 -b Human_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro5 > overlaps_rao_style/${RES}.CH.closest.panTro5

	bedtools closest -a Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.hg38 -b PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 > overlaps_rao_style/${RES}.HC.closest.hg38.pt6
	bedtools closest -a PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.hg38 -b Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.hg38 > overlaps_rao_style/${RES}.CH.closest.hg38.pt6
	bedtools closest -a Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.panTro6 -b PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro6 > overlaps_rao_style/${RES}.HC.closest.panTro6
	bedtools closest -a PT6_inter_30_KR_contact_domains/${RES}.domains.ortho.sorted.panTro6 -b Human_inter_30_KR_contact_domains_PT6/${RES}.domains.ortho.sorted.panTro6 > overlaps_rao_style/${RES}.CH.closest.panTro6

done
