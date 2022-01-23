##### get each species kegg annotation result
perl KO_list_good_format.pl Rch_KO.list 1>Rch_good.list
perl KO_list_good_format.pl Jre_KO.list 1>Jre_good.list
perl KO_list_good_format.pl Esp_KO.list 1>Esp_good.list
perl KO_list_good_format.pl Cca_KO.list >Cca_good.list
perl KO_list_good_format.pl Pla_KO.list >Pla_good.list
perl KO_list_good_format.pl Jsi_KO.list >Jsi_good.list
#####get KO annotation in DNA repair and recombination function
perl get_KO_pathway.pl Rch_good.list ../test/repair/sub-DNA-repair-ko03400.keg 1>repair.Rch
perl get_KO_pathway.pl Jre_good.list ../test/repair/sub-DNA-repair-ko03400.keg 1>repair.Jre
perl get_KO_pathway.pl Esp_good.list ../test/repair/sub-DNA-repair-ko03400.keg 1>repair.Esp
perl get_KO_pathway.pl Cca_good.list ../test/repair/sub-DNA-repair-ko03400.keg 1>repair.Cca
perl get_KO_pathway.pl Pla_good.list ../test/repair/sub-DNA-repair-ko03400.keg 1>repair.Pla
perl get_KO_pathway.pl Jsi_good.list ../test/repair/sub-DNA-repair-ko03400.keg 1>repair.Jsi
###remove duplicate line
awk '!a[$1$2]++' repair.Rch > repair.Rch.rd
awk '!a[$1$2]++' repair.Esp > repair.Esp.rd
awk '!a[$1$2]++' repair.Cca > repair.Cca.rd
awk '!a[$1$2]++' repair.Jre > repair.Jre.rd
awk '!a[$1$2]++' repair.Jsi > repair.Jsi.rd
awk '!a[$1$2]++' repair.Pla > repair.Pla.rd
####get pep and cds seq for DNA repair
perl get_repair_gene_seq.pl repair.Rch.rd /data1/dingym_data/2321-Rch/new-Rch-gff/Rch/Rch.pep 1>pep/Rch.pep
perl get_repair_gene_seq.pl repair.Pla.rd /data1/dingym_data/2321-Rch/dingym/PLST.prot.fa 1>pep/Pla.pep
perl get_repair_gene_seq.pl repair.Esp.rd /data1/dingym_data/2321-Rch/dingym/ESP.prot.fa 1>pep/Esp.pepperl get_repair_gene_seq.pl repair.Esp.rd /data1/dingym_data/2321-Rch/dingym/ESP.prot.fa 1>pep/Esp.pepperl get_repair_gene_seq.pl repair.Jre.rd /data1/dingym_data/2321-Rch/dingym/Jr_aa.fa 1>pep/Jre.pep
perl get_repair_gene_seq.pl repair.Jsi.rd /data1/dingym_data/2321-Rch/dingym/Jsi_prot.fa 1>pep/Jsi.pep
###cat DNA repair 
cat *rd >6sp.repair
###get output file
perl find_gene_in_7sporthofinder.pl pep/OrthoFinder/Results_Dec09/Orthogroups/Orthogroups.txt 6sp.repair /data1/dingym_data/2321-Rch/2021-DNA-repair/kaks/7sp-newRch/ 1>output

perl find_gene_in_7sporthofinder.pl ../orthofinder/pep/OrthoFinder/Results_Dec25/Orthogroups/Orthogroups.txt 7sp.repair kaks-result/ 1>output
##get 1:1:1:1:1:2
perl check_1_1_1_2.pl ../check-DNA-repair-result/output  1>Rch_2copy_other_1copy.txt
perl check_1_1_1_2.pl output 1>1_1_1_1_2.list
perl /data1/dingym_data/2321-Rch/2021-DNA-repair/script/Juglandaceae-Qlo/get_need_genefamily.pl 1_1_1_1_2.list  1>Rch_2copy.genelist
perl get_need_orthogroup_gene.pl Rch_2copy.genelist pep/OrthoFinder/Results_Dec09/Orthogroups/Orthogroups.txt  1>Rch_2copy.gene
##get Jre more copy gene family, please motify line 29
 perl /data1/dingym_data/2321-Rch/2021-DNA-repair/script/Juglandaceae-Qlo/get_need_genefamily.pl Rch_less.txt  1>Jre_morecopy.genelist
perl get_need_orthogroup_gene.pl Jre_morecopy.genelist pep/OrthoFinder/Results_Dec09/Orthogroups/Orthogroups.txt >Jre_morecopy.gene
###get Rch 2 copy, Jre 0 or 1 copy
perl check_back.pl output 1 1>each_combination_check/Jre01_Rch2
###get Jre 2 copy, Rch 0 or 1 gene copy
perl check.pl output 1 1>each_combination_check/Jre2_Rch01
###check 2 copy original, ks value Rch <= 0.7, orther ks<=1
perl get_OG_check_Ks.pl Cca01_Rch2 ../pep/OrthoFinder/Results_Dec09/Orthogroups/Orthogroups.txt /data1/dingym_data/2321-Rch/new-Rch-gff/Rch/Mcscan/Rch_change_format.kaks 1>Cca01_Rch2_check.ks
##check 1:1:1:2 gene RNAseq data
perl stat_expression.pl leaf_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Rch_2copy.gene 
##get table for FPKM result
perl get_FPKM.pl leaf_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Rch_2copy.gene 1>leaf_2copy_FPKM.txt
##check all repair gene in RNAseq
 perl stat_expression.pl flower_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Rch.repair.323.gene 1>new.repair.gene.RNAseq.in.flower
perl stat_expression.pl leaf_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Rch.repair.323.gene 1>new.repair.gene.RNAseq.in.leaf
 perl ../stat_expression.pl pist_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Jre.repair.279.gene 1>Jre.pist.expression
perl ../stat_expression.pl leaf_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Jre.repair.279.gene 1>Jre.leaf.expression
perl ../stat_expression.pl catkin_FPKM.csv /data1/dingym_data/2321-Rch/KEGG-enrichment/KASS/Vvi-Cuc-Jre-Qru/6sp/Jre.repair.279.gene 1>Jre.catkin.expression
###get orthogroups function annotation
perl get_OG_function.pl 6sp.repair pep/OrthoFinder/Results_Dec09/Orthogroups/Orthogroups.txt
