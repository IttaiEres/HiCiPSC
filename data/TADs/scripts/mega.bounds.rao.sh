#!/bin/bash
#This procedure frequently runs into a segmentation fault on my local device; only runs on Midway2. Find results at project2/HiC/juicer_mega/rao.domains.overlaps/overlaps_rao_style
for RES in 5000 10000 25000 50000 100000 250000 500000; do
	bedtools closest -a Human_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.hg38 -b Chimp_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.hg38 > overlaps_rao_style/${RES}.boundaries.HC.closest.hg38
	bedtools closest -a Chimp_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.hg38 -b Human_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.hg38 > overlaps_rao_style/${RES}.boundaries.CH.closest.hg38
	bedtools closest -a Human_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.panTro5 -b Chimp_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.panTro5 > overlaps_rao_style/${RES}.boundaries.HC.closest.panTro5
	bedtools closest -a Chimp_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.panTro5 -b Human_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.panTro5 > overlaps_rao_style/${RES}.boundaries.CH.closest.panTro5

	bedtools closest -a Human_inter_30_KR_contact_domains_PT6/${RES}.LO.boundaries.sorted.hg38 -b PT6_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.hg38 > overlaps_rao_style/${RES}.boundaries.HC.closest.hg38.pt6
	bedtools closest -a PT6_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.hg38 -b Human_inter_30_KR_contact_domains_PT6/${RES}.LO.boundaries.sorted.hg38 > overlaps_rao_style/${RES}.boundaries.CH.closest.hg38.pt6
	bedtools closest -a Human_inter_30_KR_contact_domains_PT6/${RES}.LO.boundaries.sorted.panTro6 -b PT6_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.panTro6 > overlaps_rao_style/${RES}.boundaries.HC.closest.panTro6
	bedtools closest -a PT6_inter_30_KR_contact_domains/${RES}.LO.boundaries.sorted.panTro6 -b Human_inter_30_KR_contact_domains_PT6/${RES}.LO.boundaries.sorted.panTro6 > overlaps_rao_style/${RES}.boundaries.CH.closest.panTro6
echo ${RES}
sleep 60
done
