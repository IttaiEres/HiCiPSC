#!/bin/bash
#Script for preparing individual arrowhead files for TAD analysis.

#No merging is done here because these calls have nested TADs.
for res in 5000 10000 25000 50000 100000 250000 500000; do #Iterate across resolutions
	mkdir -p ${res}_compare #Make the appropriate directory
	cd ${res}_compare
	for LINE in A-21792 B-28126  E-28815 F-28834; do #Iterate across individuals
		cut -f1-3,8 ../${LINE}/${res}_blocks | tail -n +2 > ${LINE}.domains #Pull out relevant columns of coords and score; remove header
		
		#Prep boundary files of entire sets of domains
		awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${LINE}.domains > ${LINE}.boundaries
		awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${LINE}.domains >> ${LINE}.boundaries
		
		#LiftOver domains
		HClift.sh H ${LINE}.domains #Liftover

		#Prep boundary files from the lifted-over domain files (both coordinates). Because arrowhead identifies domains, and not boundaries themselves here, makes most sense to LO domains and then pull boundaries from there (could also check against LO of original domain boundaries, but high overlap when previously checked).
		awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${LINE}.domains.ortho.hg38 > ${LINE}.LO.boundaries.hg38
		awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${LINE}.domains.ortho.hg38 >> ${LINE}.LO.boundaries.hg38

		awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${LINE}.domains.ortho.panTro5 > ${LINE}.LO.boundaries.panTro5
		awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${LINE}.domains.ortho.panTro5 >> ${LINE}.LO.boundaries.panTro5

		#Sort all output files so bedtools will work on them:
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.hg38 > ${LINE}.domains.ortho.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.panTro5 > ${LINE}.domains.ortho.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.LO.boundaries.hg38 > ${LINE}.LO.boundaries.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.LO.boundaries.panTro5 > ${LINE}.LO.boundaries.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.domains > ${LINE}.domains.sorted
		sort -k1,1 -k2,2n ${LINE}.boundaries > ${LINE}.boundaries.sorted
		
		
		#LiftingOver boundaries that I added/subtracted 7.5kb from either side of a domain sometimes leads to a boundary being in negative coordinates, remove these lines from the files where they came up during the first run of this script:
		grep -v "\-" ${LINE}.LO.boundaries.sorted.panTro5 > ${LINE}.LO.boundaries.sorted.panTro5
	done


	for LINE in C-3649 D-40300 G-3624 H-3651; do
		cut -f1-3,8 ../${LINE}/${res}_blocks | tail -n +2 > ${LINE}.domains #Pull out relevant columns of coords and score; remove header
		
		#Prep boundary files of entire sets of domains
		awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${LINE}.domains > ${LINE}.boundaries
		awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${LINE}.domains >> ${LINE}.boundaries
		
		HClift.sh C ${LINE}.domains #Liftover

		#Prep boundary files from the lifted-over domain files (both coordinates). Because arrowhead identifies domains, and not boundaries themselves here, makes most sense to LO domains and then pull boundaries from there (could also check against LO of original domain boundaries, but high overlap when previously checked).
		awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${LINE}.domains.ortho.hg38 > ${LINE}.LO.boundaries.hg38
		awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${LINE}.domains.ortho.hg38 >> ${LINE}.LO.boundaries.hg38

		awk '{print $1 "\t" ($2-7500) "\t" ($2+7500) "\t" $4}' ${LINE}.domains.ortho.panTro5 > ${LINE}.LO.boundaries.panTro5
		awk '{print $1 "\t" ($3-7500) "\t" ($3+7500) "\t" $4}' ${LINE}.domains.ortho.panTro5 >> ${LINE}.LO.boundaries.panTro5
		
		#Sort all output files so multiintersectbed will work on them:
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.hg38 > ${LINE}.domains.ortho.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.domains.ortho.panTro5 > ${LINE}.domains.ortho.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.LO.boundaries.hg38 > ${LINE}.LO.boundaries.sorted.hg38
		sort -k1,1 -k2,2n ${LINE}.LO.boundaries.panTro5 > ${LINE}.LO.boundaries.sorted.panTro5
		sort -k1,1 -k2,2n ${LINE}.domains > ${LINE}.domains.sorted
		sort -k1,1 -k2,2n ${LINE}.boundaries > ${LINE}.boundaries.sorted
	
	done
	cd ..
done
