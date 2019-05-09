for FILE in 5000 10000 25000 50000 100000 250000 500000; do
        #First for PT5
        bedtools merge -i Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 > Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.hg38

        bedtools merge -i Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro5 > Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.panTro5

        bedtools merge -i Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 > Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.hg38

        bedtools merge -i Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro5 > Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.panTro5

        awk '{print $0 "\t" "Human"}' Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.hg38 > overlaps/${FILE}.hg38.final
        awk '{print $0 "\t" "Chimp"}' Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.hg38 >> overlaps/${FILE}.hg38.final
        sort -k1,1 -k2,2n overlaps/${FILE}.hg38.final > overlaps/${FILE}.hg38.final.sorted
        bedtools merge -c 4 -o collapse -i overlaps/${FILE}.hg38.final.sorted > overlaps/${FILE}.hg38.final.merged

        awk '{print $0 "\t" "Human"}' Human_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.panTro5 > overlaps/${FILE}.panTro5.final
        awk '{print $0 "\t" "Chimp"}' Chimp_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.panTro5 >> overlaps/${FILE}.panTro5.final
        sort -k1,1 -k2,2n overlaps/${FILE}.panTro5.final > overlaps/${FILE}.panTro5.final.sorted
        bedtools merge -c 4 -o collapse -i overlaps/${FILE}.panTro5.final.sorted > overlaps/${FILE}.panTro5.final.merged


		#Now for PT6!
		bedtools merge -i Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.sorted.hg38 > Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.merged.hg38

        bedtools merge -i Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.sorted.panTro6 > Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.merged.panTro6

        bedtools merge -i PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.hg38 > PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.hg38

        bedtools merge -i PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.sorted.panTro6 > PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.panTro6

        awk '{print $0 "\t" "Human"}' Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.merged.hg38 > overlaps/${FILE}.hg38.pt6.final
        awk '{print $0 "\t" "Chimp"}' PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.hg38 >> overlaps/${FILE}.hg38.pt6.final
        sort -k1,1 -k2,2n overlaps/${FILE}.hg38.pt6.final > overlaps/${FILE}.hg38.pt6.final.sorted
        bedtools merge -c 4 -o collapse -i overlaps/${FILE}.hg38.pt6.final.sorted > overlaps/${FILE}.hg38.pt6.final.merged

        awk '{print $0 "\t" "Human"}' Human_inter_30_KR_contact_domains_PT6/${FILE}.LO.boundaries.merged.panTro6 > overlaps/${FILE}.panTro6.final
        awk '{print $0 "\t" "Chimp"}' PT6_inter_30_KR_contact_domains/${FILE}.LO.boundaries.merged.panTro6 >> overlaps/${FILE}.panTro6.final
        sort -k1,1 -k2,2n overlaps/${FILE}.panTro6.final > overlaps/${FILE}.panTro6.final.sorted
        bedtools merge -c 4 -o collapse -i overlaps/${FILE}.panTro6.final.sorted > overlaps/${FILE}.panTro6.final.merged

done

#Note that the 100kb and 250kb versions of LO'd boundaries from humans to panTro5 had negative coordinates, so had to remove them first:
#grep -v "\-" Human_inter_30_KR_contact_domains/100000.LO.boundaries.sorted.panTro5 > Human_inter_30_KR_contact_domains/100000.LO.boundaries.sorted.panTro5
#grep -v "\-" Human_inter_30_KR_contact_domains/250000.LO.boundaries.sorted.panTro5 > Human_inter_30_KR_contact_domains/250000.LO.boundaries.sorted.panTro5
#Same also happened on 10, 25, 50, and 100kb versions of humans to panTro6:
#grep -v "\-" Human_inter_30_KR_contact_domains_PT6/10000.LO.boundaries.sorted.panTro6 > Human_inter_30_KR_contact_domains_PT6/10000.LO.boundaries.sorted.panTro6
#grep -v "\-" Human_inter_30_KR_contact_domains_PT6/25000.LO.boundaries.sorted.panTro6 > Human_inter_30_KR_contact_domains_PT6/25000.LO.boundaries.sorted.panTro6
#grep -v "\-" Human_inter_30_KR_contact_domains_PT6/50000.LO.boundaries.sorted.panTro6 > Human_inter_30_KR_contact_domains_PT6/50000.LO.boundaries.sorted.panTro6
#grep -v "\-" Human_inter_30_KR_contact_domains_PT6/100000.LO.boundaries.sorted.panTro6 > Human_inter_30_KR_contact_domains_PT6/100000.LO.boundaries.sorted.panTro6



#Last used/created 4-23-19
