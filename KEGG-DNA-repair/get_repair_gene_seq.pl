use strict;
use warnings;
sub help{
	print "pelr xxx.pl DNA.repair.rd sp.pep\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my @gene;
	while(<IN>){
		chomp;
		my @it = split(/\t/,$_);
		push @gene,$it[1];
	}
	close(IN);
	open(FA,"$ARGV[1]") or die;
	my $gene;
	my %seq;
	while(<FA>){
		chomp;
		if(/^>(.*)/){
			$gene = $1;
		}else{
			$seq{$gene} .= $_;
		}
	}
	close(FA);
	foreach my $i(@gene){
		print ">$i\n$seq{$i}\n";
	}
}
