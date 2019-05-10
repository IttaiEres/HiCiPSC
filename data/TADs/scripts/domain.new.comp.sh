#!/bin/bash
for res in 5000 10000 25000 50000 100000 250000 500000; do #Iterate across resolutions
	cd ${res}_compare
		
	###DOMAIN COMPARISONS
	#Now, run actual comparisons between the files. Both bedtools modules I use allow to assess against multiple databases, so just create two files per individual (one with human and one with chimp coords). First, bedtools closest for Rao method of domain comparison:
	
	#Since I am dealing with multiple files here with elements that may only be off by a little bit, I need a way to combine down to a union list of TADs. Hence, I first use multiintersectbed within each species to create files of shared TAD structure within each species. Then I use these later on to call conservation.
	#multiintersectbed -i A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -cluster -names A B E F > human.multi.clust.domains
	#Multi will merge nested TADs, no good! Need to do individual bedtools closest and intersect -c pairwise comparisons and take the average....unghhh
	#Not so difficult for intra comparisons, can just average the >1 categories and add the 1 categories.
	
	##Intraspecies variance, Humans##
	#Ortho only#
	bedtools closest -a A-21792.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > A.intra.rao.ortho.hg38
	bedtools closest -a B-28126.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > B.intra.rao.ortho.hg38
	bedtools closest -a E-28815.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > E.intra.rao.ortho.hg38
	bedtools closest -a F-28834.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > F.intra.rao.ortho.hg38
	
	bedtools intersect -loj -f 0.9 -r -a A-21792.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > A.intra.loj.ortho.hg38
	bedtools intersect -loj -f 0.9 -r -a B-28126.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > B.intra.loj.ortho.hg38
	bedtools intersect -loj -f 0.9 -r -a E-28815.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > E.intra.loj.ortho.hg38
	bedtools intersect -loj -f 0.9 -r -a F-28834.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 -names A B E F > F.intra.loj.ortho.hg38
	
	#Full#
	bedtools closest -a A-21792.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > A.intra.rao.full.hg38
	bedtools closest -a B-28126.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > B.intra.rao.full.hg38
	bedtools closest -a E-28815.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > E.intra.rao.full.hg38
	bedtools closest -a F-28834.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > F.intra.rao.full.hg38
	
	bedtools intersect -loj -f 0.9 -r -a A-21792.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > A.intra.loj.full.hg38
	bedtools intersect -loj -f 0.9 -r -a B-28126.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > B.intra.loj.full.hg38
	bedtools intersect -loj -f 0.9 -r -a E-28815.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > E.intra.loj.full.hg38
	bedtools intersect -loj -f 0.9 -r -a F-28834.domains.sorted -b A-21792.domains.sorted B-28126.domains.sorted E-28815.domains.sorted F-28834.domains.sorted -names A B E F > F.intra.loj.full.hg38
	
	##Intraspecies variance, Chimps##
	#Ortho only#
	bedtools closest -a C-3649.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > C.intra.rao.ortho.hg38
	bedtools closest -a D-40300.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > D.intra.rao.ortho.hg38
	bedtools closest -a G-3624.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > G.intra.rao.ortho.hg38
	bedtools closest -a H-3651.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > H.intra.rao.ortho.hg38
	
	bedtools intersect -loj -f 0.9 -r -a C-3649.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > C.intra.loj.ortho.hg38
	bedtools intersect -loj -f 0.9 -r -a D-40300.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > D.intra.loj.ortho.hg38
	bedtools intersect -loj -f 0.9 -r -a G-3624.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > G.intra.loj.ortho.hg38
	bedtools intersect -loj -f 0.9 -r -a H-3651.domains.ortho.sorted.hg38 -b C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names C D G H > H.intra.loj.ortho.hg38
	
	#Full#
	bedtools closest -a C-3649.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > C.intra.rao.full.hg38
	bedtools closest -a D-40300.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > D.intra.rao.full.hg38
	bedtools closest -a G-3624.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > G.intra.rao.full.hg38
	bedtools closest -a H-3651.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > H.intra.rao.full.hg38
	
	bedtools intersect -loj -f 0.9 -r -a C-3649.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > C.intra.loj.full.hg38
	bedtools intersect -loj -f 0.9 -r -a D-40300.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > D.intra.loj.full.hg38
	bedtools intersect -loj -f 0.9 -r -a G-3624.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > G.intra.loj.full.hg38
	bedtools intersect -loj -f 0.9 -r -a H-3651.domains.sorted -b C-3649.domains.sorted D-40300.domains.sorted G-3624.domains.sorted H-3651.domains.sorted -names C D G H > H.intra.loj.full.hg38
	
	##Interspecies variance, pairwise#
	bedtools closest -a A-21792.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.A.rao
	bedtools closest -a B-28126.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.B.rao
	bedtools closest -a C-3649.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.C.rao
	bedtools closest -a D-40300.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.D.rao
	bedtools closest -a E-28815.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.E.rao
	bedtools closest -a F-28834.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.F.rao
	bedtools closest -a G-3624.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.G.rao
	bedtools closest -a H-3651.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.H.rao
	
	bedtools intersect -loj -f 0.9 -r -a A-21792.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.A.loj
	bedtools intersect -loj -f 0.9 -r -a B-28126.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.B.loj
	bedtools intersect -loj -f 0.9 -r -a C-3649.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.C.loj
	bedtools intersect -loj -f 0.9 -r -a D-40300.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.D.loj
	bedtools intersect -loj -f 0.9 -r -a E-28815.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.E.loj
	bedtools intersect -loj -f 0.9 -r -a F-28834.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.F.loj
	bedtools intersect -loj -f 0.9 -r -a G-3624.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.G.loj
	bedtools intersect -loj -f 0.9 -r -a H-3651.domains.ortho.sorted.hg38 -b A-21792.domains.ortho.sorted.hg38 B-28126.domains.ortho.sorted.hg38 C-3649.domains.ortho.sorted.hg38 D-40300.domains.ortho.sorted.hg38 E-28815.domains.ortho.sorted.hg38 F-28834.domains.ortho.sorted.hg38 G-3624.domains.ortho.sorted.hg38 H-3651.domains.ortho.sorted.hg38 -names A B C D E F G H > inter.H.loj
	
	cd ..
done
