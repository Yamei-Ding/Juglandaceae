use strict;
use warnings;
sub help{
	print "pelr xxx.pl Jre01_Rch2 orthogroups.txt  Rch.colo.kaks \n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my @og;
	while(<IN>){
		chomp;
		my @it = split(/\s+/,$_);
		push @og,$it[0];
	}
	close(IN);
	open(IN,"$ARGV[1]") or die;
	my %dup;
	while(<IN>){
		chomp;
		my @it = split(/\:/,$_);
		my @tmp = split(/\s/,$it[1]);
		foreach my $i(@tmp){
			if($i =~ /Rch/){
				push @{$dup{$it[0]}},$i;
			}
		}
	}
	close(IN);
	open(KS,"$ARGV[2]") or die;
	my %ks;
	while(<KS>){
		chomp;
		next if(/^>/);
		my @it = split(/\t/,$_);
		$ks{"$it[0]-$it[1]"} = $it[4];
		$ks{"$it[1]-$it[0]"} = $it[4];
	}
	close(KS);
	my $num_pair = 0;
	my $bed_ks = 0;
	my $bed_pair = 0;
	foreach my $i(@og){
		my $gene1 = $dup{$i}[0];
		my $gene2 = $dup{$i}[1];
		my $tmp = "$gene1-$gene2";
		$num_pair++;
		if(exists $ks{$tmp}){
			print "$i\t$ks{$tmp}\n";
			if($ks{$tmp} > 0.7){
				$bed_ks++;
			}
		}else{
			print "$i\tbed\n";
			$bed_pair++;
		}
	}
	print "Total orthogroups:$num_pair\tks>0.7:$bed_ks\tno ks:$bed_pair\n";
}
