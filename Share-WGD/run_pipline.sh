####change collinearity.kaks format
perl change_format_collinearity.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Aro/A5G25/Aro.collinearity 1>/data1/dingym_data/2321-Rch/gogogo/Mcscan/Aro/A5G25/Aro_changeformat.kaks 
###select recent WGD block for paralog
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Aro/A5G25/Aro_changeformat.kaks 1 0.6 1>../paralog/Aro.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Cil/A5G25/Cil_change_format.kaks 1 0.6 1>../paralog/Cil.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Pla/A5G25/Pla_changeformat.kaks 1 0.6 1>../paralog/Pla.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Jre/A5G25/Jre_changeformat.kaks 1 0.6 1>../paralog/Jre.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Jmad/A5G25/Jma_changeformt.kaks 1 0.6 1>../paralog/Jma.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Jmic/A5G25/Jmi_changeformat.kaks 1 0.6 1>../paralog/Jmi.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch/A5G25/Rch_changeformat.kaks 1 0.6 1>../paralog/Rch.nogamma.kaks
###select ortholog genes 
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch_Jmi/Mcscan/Rch_Jmi.changeformat.kaks 1 0.6 1>../ortholog/Rch_Jmi.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch_Aro/Mcscan/Rch_Aro.changeformat.kaks 1 0.6 1>../ortholog/Rch_Aro.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch_Pla/Mcscan/Rch_Pla.changeformat.kaks 1 0.6 1>../ortholog/Rch_Pla.nogamma.kaks
 perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch_Cil/Mcscan/Rch_Cil.changeformat.kaks 1 0.6 1>../ortholog/Rch_Cil.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch_Jre/Mcscan/Rch_Jre.changeformat.kaks 1 0.6 1>../ortholog/Rch_Jre.nogamma.kaks
perl select_ks_block.pl /data1/dingym_data/2321-Rch/gogogo/Mcscan/Rch_Jma/Mcscan/Rch_Jma.changeformat.kaks 1 0.6 1>../ortholog/Rch_Jma.nogamma.kaks
####select quartets and construct gene trees
perl select_treenode_gapcheck_iqtree.pl Aro /data1/dingym_data/2321-Rch/gogogo/share-WGD/OrthoFinder/Orthogroups/Orthogroups.txt ../nogamma-block-homolog/cds/ ../nogamma-block-homolog/pep/ ../nogamma-block-homolog/paralog/ ../nogamma-block-homolog/ortholog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/result-for-shareWGD/Rch_Aro/ &>Rch_Aro.log
 perl select_treenode_gapcheck_iqtree.pl CiP /data1/dingym_data/2321-Rch/gogogo/share-WGD/OrthoFinder/Orthogroups/Orthogroups.txt ../nogamma-block-homolog/cds/ ../nogamma-block-homolog/pep/ ../nogamma-block-homolog/paralog/ ../nogamma-block-homolog/ortholog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/result-for-shareWGD/Rch_Cil/ &>Rch_Cil.log
perl select_treenode_gapcheck_iqtree.pl Pla /data1/dingym_data/2321-Rch/gogogo/share-WGD/OrthoFinder/Orthogroups/Orthogroups.txt ../nogamma-block-homolog/cds/ ../nogamma-block-homolog/pep/ ../nogamma-block-homolog/paralog/ ../nogamma-block-homolog/ortholog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/result-for-shareWGD/Rch_Pla/ &>Rch_Pla.log
perl select_treenode_gapcheck_iqtree.pl Jre /data1/dingym_data/2321-Rch/gogogo/share-WGD/OrthoFinder/Orthogroups/Orthogroups.txt ../nogamma-block-homolog/cds/ ../nogamma-block-homolog/pep/ ../nogamma-block-homolog/paralog/ ../nogamma-block-homolog/ortholog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/result-for-shareWGD/Rch_Pla/ &>Rch_Jre.log
perl select_treenode_gapcheck_iqtree.pl Jma /data1/dingym_data/2321-Rch/gogogo/share-WGD/OrthoFinder/Orthogroups/Orthogroups.txt ../nogamma-block-homolog/cds/ ../nogamma-block-homolog/pep/ ../nogamma-block-homolog/paralog/ ../nogamma-block-homolog/ortholog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/result-for-shareWGD/Rch_Pla/ &>Rch_Jma.log
perl select_treenode_gapcheck_iqtree.pl Jmi /data1/dingym_data/2321-Rch/gogogo/share-WGD/OrthoFinder/Orthogroups/Orthogroups.txt ../nogamma-block-homolog/cds/ ../nogamma-block-homolog/pep/ ../nogamma-block-homolog/paralog/ ../nogamma-block-homolog/ortholog/ /data1/dingym_data/2321-Rch/gogogo/share-WGD/result-for-shareWGD/Rch_Pla/ &>Rch_Jmi.log 
###count each topology number
perl count_tree.pl Aro Rch 80  ../result-for-shareWGD/Rch_Aro/Aro/Aro-tree/ reroot 1>Rch_Aro.bt80
###get bt>80 tree
sed -n "6p" Rch_Aro.bt80 1>Aro.bt80.list
sed -i "s/\s/\n/g" Aro.bt80.list 
perl ../../script/getC22node.pl Aro.bt80.list Aro/Aro-tree/ 1>gene.pair
perl ~/perl5/handle_MCScanX/kaks.pl gene.pair 1 Rch_Jma.cds Rch_Jma.pep gene.pair.kaks
##for Cil
perl get_Cil_kaks.pl 2163211.tttkaks gene.pair 1>gene.pair.kaks 2>error
###calculate evolution rate, please motify the 22,23 line $4 = Ks, $5 = Ka/Ks
perl get_2sp-duptime_kska.pl ../result-for-shareWGD/Rch_Aro/Aro.bt80.list ../result-for-shareWGD/Rch_Aro/Aro/Aro-tree/ ../result-for-shareWGD/Rch_Aro/gene.pair.kaks Aro Rch ../result-for-shareWGD/Rch_Aro/Rch_Aro.kaks
