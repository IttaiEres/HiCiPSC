#!/bin/bash
for res in 10000 25000 50000 100000 250000 500000; do #Iterate across resolutions
	cd ${res}_compare
	
	###Boundary Comparisons, Intraspecies###
	#First, create boundary files merging within individuals and then within species, and then one set only merging within species, to assess intra-species variance. Makes sense to merge here because boundaries are thought of as insulator elements and nested TADs could often share boundaries...
	#Humans, merging each file
	bedtools merge -i A-21792.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "A"}' > h.merge.ortho.hg38.final
	bedtools merge -i B-28126.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "B"}' >> h.merge.ortho.hg38.final
	bedtools merge -i E-28815.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "E"}' >> h.merge.ortho.hg38.final
	bedtools merge -i F-28834.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "F"}' >> h.merge.ortho.hg38.final
	bedtools merge -c 4 -o collapse -i <(sort -k1,1 -k2,2n h.merge.ortho.hg38.final) > h.final.allmerge.ortho.hg38
	
	bedtools merge -i A-21792.boundaries.sorted | awk '{print $0 "\t" "A"}' > h.merge.hg38.final
	bedtools merge -i B-28126.boundaries.sorted | awk '{print $0 "\t" "B"}' >> h.merge.hg38.final
	bedtools merge -i E-28815.boundaries.sorted | awk '{print $0 "\t" "E"}' >> h.merge.hg38.final
	bedtools merge -i F-28834.boundaries.sorted | awk '{print $0 "\t" "F"}' >> h.merge.hg38.final
	bedtools merge -c 4 -o collapse -i <(sort -k1,1 -k2,2n h.merge.hg38.final) > h.final.allmerge.hg38
		
	#Chimps, merging each file
	bedtools merge -i C-3649.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "C"}' > c.merge.ortho.hg38.final
	bedtools merge -i D-40300.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "D"}' >> c.merge.ortho.hg38.final
	bedtools merge -i G-3624.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "G"}' >> c.merge.ortho.hg38.final
	bedtools merge -i H-3651.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "H"}' >> c.merge.ortho.hg38.final
	bedtools merge -c 4 -o collapse -i <(sort -k1,1 -k2,2n c.merge.ortho.hg38.final) > c.final.allmerge.ortho.hg38
	
	bedtools merge -i C-3649.boundaries.sorted | awk '{print $0 "\t" "C"}' > c.merge.panTro5.final
	bedtools merge -i D-40300.boundaries.sorted | awk '{print $0 "\t" "D"}' >> c.merge.panTro5.final
	bedtools merge -i G-3624.boundaries.sorted | awk '{print $0 "\t" "G"}' >> c.merge.panTro5.final
	bedtools merge -i H-3651.boundaries.sorted | awk '{print $0 "\t" "H"}' >> c.merge.panTro5.final
	bedtools merge -c 4 -o collapse -i <(sort -k1,1 -k2,2n c.merge.panTro5.final) > c.final.allmerge.panTro5
	
	#Jaccard Indices
	bedtools jaccard -a A-21792.boundaries.sorted -b B-28126.boundaries.sorted > jac.AB.full
	bedtools jaccard -a A-21792.boundaries.sorted -b E-28815.boundaries.sorted > jac.AE.full
	bedtools jaccard -a A-21792.boundaries.sorted -b F-28834.boundaries.sorted > jac.AF.full
	bedtools jaccard -a B-28126.boundaries.sorted -b F-28834.boundaries.sorted > jac.BF.full
	bedtools jaccard -a B-28126.boundaries.sorted -b E-28815.boundaries.sorted > jac.BE.full
	bedtools jaccard -a E-28815.boundaries.sorted -b F-28834.boundaries.sorted > jac.EF.full
	
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b B-28126.boundaries.ortho.sorted.hg38 > jac.AB.ortho
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b E-28815.boundaries.ortho.sorted.hg38 > jac.AE.ortho
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b F-28834.boundaries.ortho.sorted.hg38 > jac.AF.ortho
	bedtools jaccard -a B-28126.boundaries.ortho.sorted.hg38 -b F-28834.boundaries.ortho.sorted.hg38 > jac.BF.ortho
	bedtools jaccard -a B-28126.boundaries.ortho.sorted.hg38 -b E-28815.boundaries.ortho.sorted.hg38 > jac.BE.ortho
	bedtools jaccard -a E-28815.boundaries.ortho.sorted.hg38 -b F-28834.boundaries.ortho.sorted.hg38 > jac.EF.ortho
	
	bedtools jaccard -a C-3649.boundaries.sorted -b D-40300.boundaries.sorted > jac.CD.full
	bedtools jaccard -a C-3649.boundaries.sorted -b G-3624.boundaries.sorted > jac.CG.full
	bedtools jaccard -a C-3649.boundaries.sorted -b H-3651.boundaries.sorted > jac.CH.full
	bedtools jaccard -a D-40300.boundaries.sorted -b H-3651.boundaries.sorted > jac.DH.full
	bedtools jaccard -a D-40300.boundaries.sorted -b G-3624.boundaries.sorted > jac.DG.full
	bedtools jaccard -a G-3624.boundaries.sorted -b H-3651.boundaries.sorted > jac.GH.full
	
	bedtools jaccard -a C-3649.boundaries.ortho.sorted.hg38 -b D-40300.boundaries.ortho.sorted.hg38 > jac.CD.ortho
	bedtools jaccard -a C-3649.boundaries.ortho.sorted.hg38 -b G-3624.boundaries.ortho.sorted.hg38 > jac.CG.ortho
	bedtools jaccard -a C-3649.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.CH.ortho
	bedtools jaccard -a D-40300.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.DH.ortho
	bedtools jaccard -a D-40300.boundaries.ortho.sorted.hg38 -b G-3624.boundaries.ortho.sorted.hg38 > jac.DG.ortho
	bedtools jaccard -a G-3624.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.GH.ortho
	
	###Boundary Comparisons, Interspecies###
	bedtools merge -i C-3649.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "C"}' > combined.each.merge.ortho.hg38.final
	bedtools merge -i D-40300.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "D"}' >> combined.each.merge.ortho.hg38.final
	bedtools merge -i G-3624.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "G"}' >> combined.each.merge.ortho.hg38.final
	bedtools merge -i H-3651.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "H"}' >> combined.each.merge.ortho.hg38.final
	bedtools merge -i A-21792.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "A"}' >> combined.each.merge.ortho.hg38.final
	bedtools merge -i B-28126.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "B"}' >> combined.each.merge.ortho.hg38.final
	bedtools merge -i E-28815.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "E"}' >> combined.each.merge.ortho.hg38.final
	bedtools merge -i F-28834.boundaries.ortho.sorted.hg38 | awk '{print $0 "\t" "F"}' >> combined.each.merge.ortho.hg38.final
	
	bedtools merge -c 4 -o collapse -i <(sort -k1,1 -k2,2n combined.each.merge.ortho.hg38.final) > final.merged.combined.each.merge.ortho.hg38
	
	#Jaccard indices
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b C-3649.boundaries.ortho.sorted.hg38 > jac.AC.ortho
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b D-40300.boundaries.ortho.sorted.hg38 > jac.AD.ortho
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b G-3624.boundaries.ortho.sorted.hg38 > jac.AG.ortho
	bedtools jaccard -a A-21792.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.AH.ortho
	
	bedtools jaccard -a B-28126.boundaries.ortho.sorted.hg38 -b C-3649.boundaries.ortho.sorted.hg38 > jac.BC.ortho
	bedtools jaccard -a B-28126.boundaries.ortho.sorted.hg38 -b D-40300.boundaries.ortho.sorted.hg38 > jac.BD.ortho
	bedtools jaccard -a B-28126.boundaries.ortho.sorted.hg38 -b G-3624.boundaries.ortho.sorted.hg38 > jac.BG.ortho
	bedtools jaccard -a B-28126.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.BH.ortho
	
	bedtools jaccard -a E-28815.boundaries.ortho.sorted.hg38 -b C-3649.boundaries.ortho.sorted.hg38 > jac.EC.ortho
	bedtools jaccard -a E-28815.boundaries.ortho.sorted.hg38 -b D-40300.boundaries.ortho.sorted.hg38 > jac.ED.ortho
	bedtools jaccard -a E-28815.boundaries.ortho.sorted.hg38 -b G-3624.boundaries.ortho.sorted.hg38 > jac.EG.ortho
	bedtools jaccard -a E-28815.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.EH.ortho
	
	bedtools jaccard -a F-28834.boundaries.ortho.sorted.hg38 -b C-3649.boundaries.ortho.sorted.hg38 > jac.FC.ortho
	bedtools jaccard -a F-28834.boundaries.ortho.sorted.hg38 -b D-40300.boundaries.ortho.sorted.hg38 > jac.FD.ortho
	bedtools jaccard -a F-28834.boundaries.ortho.sorted.hg38 -b G-3624.boundaries.ortho.sorted.hg38 > jac.FG.ortho
	bedtools jaccard -a F-28834.boundaries.ortho.sorted.hg38 -b H-3651.boundaries.ortho.sorted.hg38 > jac.FH.ortho
	
	cd ..
done
