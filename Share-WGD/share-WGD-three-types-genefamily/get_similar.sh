##get each species max and min ks range
#perl order_ks_value.pl Rch_Aro.ks Aro
####the Rch peak and Jre Ks peak $1 is the Rch_Aro.Ks $2 is the peak of Rch, $3 is the peak of Aro
perl get_assign_ks_value.pl $1 $2 $3 >similar.ks
sh grep.sh similar.ks $4  1>${4}.similar.kaks
