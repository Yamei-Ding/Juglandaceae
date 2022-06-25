###get gene family and construct tree
perl5.16.3 new-get-gene-gamily.pl Jma OrthoFinder/Orthogroups/Orthogroups.txt nogamma-block-homolog/cds/ nogamma-block-homolog/pep/ nogamma-block-homolog/ortholog+paralog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/kkk/ &>jma.log 
####summary the topology
perl new_count_tree.pl Jmi Rch 70 ../kkk/Jmi/Jmi-tree/ root 1>Jmi_Rch.bt70 

###get good topology tree list
perl get_tree_list.pl summary-topology-result/ bt80
sed -i 's/ /\n/g' *.list
##get ks value,please motify the 28,29 line, $3 is Ka, $4 is Ks, $5 is Kaks
perl get_2sp-duptime_kska.pl Jre_Rch.list ../kkk/Jre/Jre-tree/ ../nogamma-block-homolog/ortholog+paralog/ Jre Rch > Jre_Rch.ks
####get similar ks tree the kaks value
sh get_similar.sh Ks-result/Aro_Rch.ks 0.043932 0.1659293 Aro_Rch.kaks 
