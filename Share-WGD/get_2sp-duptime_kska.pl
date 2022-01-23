#!/usr/bin/perl -w
use strict;
use package;
sub help
{
	print "perl xxx.pl treelist path_tree gpair.kaks sp1name sp2name outfile(sp1dupksname sp1dupkaname sp2dupksname sp2dupkaname) \n";
	print "spname:nodename prefix in treefile\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	my $trees=&read_list($ARGV[0]);
	my %gpair_ks;
	open(IN,$ARGV[2])or die "$!\n";
	while(<IN>)
	{
		/(\S*)\t(\S*)\t(\S*)\t(\S*)\t(\S*)/;
		$gpair_ks{"$1 $2"}=$4;
		$gpair_ks{"$2 $1"}=$4;
	}
	close(IN);
    my ($sp1name,$sp2name)=($ARGV[3],$ARGV[4]);
	my @sp1ks;
	my @sp2ks;
	my($node1,$node2,$node3,$node4);
	foreach my $tree (@{$trees})
	{
		open(IN,"$ARGV[1]/$tree")or die "$!\n";
		while(<IN>)
		{
			/\(([^()]*?):[^()]*?,([^()]*?):.*?\((\S*?):.*?,(\S*?):/;
			($node1,$node2,$node3,$node4)=($1,$2,$3,$4);
			if($node1=~/^$sp1name/ && $node3=~/^$sp1name/)
			{
				if(($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4 >=0 && ($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4 >= 0){
					push(@sp1ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4);
					push(@sp2ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4);
				}
				if(($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4 >= 0 && ($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4 >= 0 ){
					push(@sp1ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4);
					push(@sp2ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4);
}
			}
			elsif($node1=~/^$sp1name/ && $node3=~/^$sp2name/)
			{
				if(($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4 >= 0 && ($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4 >= 0){
					push(@sp1ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4);
					push(@sp2ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4);
}
				if(($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4 >= 0 && ($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4 >= 0){
				push(@sp2ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4);
				push(@sp1ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4);
}
			}
			elsif($node1=~/^$sp2name/ && $node3=~/^$sp1name/)
			{
				if(($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4 >= 0 && ($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4 >= 0){
				push(@sp2ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4);
				push(@sp1ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4);
} 
				if(($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4 >= 0 && ($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4 >= 0){
				push(@sp1ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4);
				push(@sp2ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4);
}
			}
			else
			{
				if(($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4 >=0 && ($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4 >= 0){
				push(@sp2ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node2 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node2 $node4"})/4);
				push(@sp1ks,"$tree\t".($gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node1 $node2"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node1 $node4"})/4);
}
				if(($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4 >= 0 && ($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4 >= 0){
				push(@sp2ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node3"}-$gpair_ks{"$node1 $node4"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node3"}-$gpair_ks{"$node2 $node4"})/4);
				push(@sp1ks,"$tree\t".($gpair_ks{"$node3 $node4"}+$gpair_ks{"$node1 $node4"}-$gpair_ks{"$node1 $node3"}+$gpair_ks{"$node3 $node4"}+$gpair_ks{"$node2 $node4"}-$gpair_ks{"$node2 $node3"})/4);
}
			}
		}
		close(IN);
		open(OUT,">./$ARGV[5]")or die "$!\n";
		my $i=0;
		foreach(@sp1ks)
		{
			print OUT"$sp1ks[$i]\t$sp1name\n$sp2ks[$i]\t$sp2name\n";
			$i++;
		}
		close(OUT);
	}
}
