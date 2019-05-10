#!/bin/bash
#Script for preparing individual arrowhead files for TAD analysis.

#No merging is done here because these calls have nested TADs.
for res in 10000 25000 50000 100000 250000 500000; do #Iterate across resolutions
	simpres=$((res/1000))
	mkdir -p ${res}_compare #Make the appropriate directory
	cd ${res}_compare
	for LINE in A-21792 B-28126  E-28815 F-28834; do #Iterate across individuals
		grep domain ../results/${simpres}kb/20/${LINE}_TOPDOM_ALL.domain | cut -f1,3,5 > ${LINE}.domains
		grep boundary ../results/${simpres}kb/20/${LINE}_TOPDOM_ALL.domain | cut -f1,3,5 > ${LINE}.boundaries
		
		#LiftOver both
		HClift.sh H ${LINE}.domains #Liftover
		HClift.sh H ${LINE}.boundaries

		#Sort all output files so bedtools will work on them:
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.hg38 > ${LINE}.domains.ortho.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.panTro5 > ${LINE}.domains.ortho.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.boundaries.ortho.hg38 > ${LINE}.boundaries.ortho.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.boundaries.ortho.panTro5 > ${LINE}.boundaries.ortho.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.domains > ${LINE}.domains.sorted
		sort -k1,1 -k2,2n ${LINE}.boundaries > ${LINE}.boundaries.sorted

	done


	for LINE in C-3649 D-40300 G-3624 H-3651; do
		grep domain ../results/${simpres}kb/20/${LINE}_TOPDOM_ALL.domain | cut -f1,3,5 > ${LINE}.domains
		grep boundary ../results/${simpres}kb/20/${LINE}_TOPDOM_ALL.domain | cut -f1,3,5 > ${LINE}.boundaries
		
		#LiftOver both
		HClift.sh C ${LINE}.domains #Liftover
		HClift.sh C ${LINE}.boundaries

		#Sort all output files so bedtools will work on them:
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.hg38 > ${LINE}.domains.ortho.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.panTro5 > ${LINE}.domains.ortho.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.boundaries.ortho.hg38 > ${LINE}.boundaries.ortho.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.boundaries.ortho.panTro5 > ${LINE}.boundaries.ortho.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.domains > ${LINE}.domains.sorted
		sort -k1,1 -k2,2n ${LINE}.boundaries > ${LINE}.boundaries.sorted

	done
	cd ..
done

