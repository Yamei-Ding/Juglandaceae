#!/usr/bin/perl -w
use strict;
use package;
sub help
{
	print "perl xxx.pl treelist path_tree path_syn sp1name sp2name\n";
	print "spname: nodename prefix in treefile\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	my ($tree_file,$path_tree,$path_syn,$sp1name,$sp2name,$out)=@ARGV;
	my $trees=&read_list($tree_file);
	#obtain ks of each gpair
	my %gpair_ks;
	my @files=split/\n/,`ls $path_syn`;
	foreach my $f(@files)
	{
		open(IN,"$path_syn/$f")or die "$!\n";
		while(<IN>)
		{
			#if(/^([^>]\S*)\t(\S*)\t\S+\t\S+\t(\S*)/)
			if(/^([^>]\S*)\t(\S*)\t\S+\t(\S+)\t(\S+)\t(\S*)/) #$1,$2 is gene pair, $3 is Ka, $4 is Ks, $5 is Ka/ks
			{
			$gpair_ks{"$1 $2"}=$5;
			$gpair_ks{"$2 $1"}=$5;
			}
		}
		close(IN);
	}
	my($node1,$node2,$node3,$node4);
	foreach my $t (@{$trees})
	{
		my @sp1ks=();
		my @sp2ks=();
		my $tree=`nw_topology $path_tree/$t`;
		my $supp_num=($tree=~s/\)\d+/\)/g);
		#print "#$tree$supp_num\n";
		my ($ks1,$ks2,$ks3,$ks4)=();
		my $right_name;
		if($supp_num == 2)
		{
			#((node1[A],node2[B]),(node3[A],node4[B]))
			if($tree=~/\((($sp1name|$sp2name).*?),(.*?)\),\((($sp1name|$sp2name).*?),(.*?)\)/  && $2 eq $5)
			{($node1,$right_name,$node2,$node3,$node4)=($1,$2,$3,$4,$6);}
			else{($node1,$right_name,$node2,$node3,$node4)=($1,$2,$3,$6,$4);}
			#print "$node1,$right_name,$node2,$node3,$node4\n";
			$ks1=($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4;
			$ks2=($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4;
			$ks3=($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4;
			$ks4=($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4;
			if ($ks1 >0 && $ks2>0 && $ks3 >0 && $ks4>0)
			{
				if($right_name eq $sp1name){
					push (@sp1ks,$ks1);
					push (@sp1ks,$ks3);
					push (@sp2ks,$ks2);
					push (@sp2ks,$ks4);
				}else{
					push (@sp1ks,$ks2);
					push (@sp1ks,$ks4);
					push (@sp2ks,$ks1);
					push (@sp2ks,$ks3);
				}
			}
		}
		elsif($supp_num == 1)
		{
			#((node1,node2),node3)
			if($tree=~/\(\((($sp1name|$sp2name)[^(),]*?),([^(),]*?)\),([^(),]*?)\)/)
			{
				($node1,$right_name,$node2,$node3)=($1,$2,$3,$4);
			}
			#(node3,(node1[right],$node2))
			else
			{
				$tree=~/\(([^(),]*?),\((($sp1name|$sp2name)[^(),]*?),([^(),]*?)\)\)/;
				($node1,$right_name,$node2,$node3)=($2,$3,$4,$1);
			}
			#print "$node1,$right_name,$node2,$node3\n";
			$ks1=($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"})/2;
			$ks2=($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"})/2;
			if($ks1 >0 && $ks2>0)
			{
				if($right_name eq $sp1name)
				{
					push (@sp1ks,$ks1);
					push (@sp2ks,$ks2);
				}else{
					push (@sp1ks,$ks2);
					push (@sp2ks,$ks1);
				}
			}
		}
		grep {print "$t\t$_\t$sp1name\n";}@sp1ks;
		grep {print "$t\t$_\t$sp2name\n";}@sp2ks;
	}
}
