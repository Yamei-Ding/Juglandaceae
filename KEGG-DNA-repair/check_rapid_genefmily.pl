use strict;
use warnings;
sub help{
	print "perl xx.pl gene.name\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my @gene;
	while(<IN>){
		chomp;
		push @gene,$_;
	}
	close(IN);
	open(IN,"$ARGV[1]") or die;
	my %infor;
	while(<IN>){
		chomp;
		my @it = split(/\t/,$_);
		$infor{$it[1]} = $_;
	}
	close(IN);
	foreach my $i(@gene){
		if(exists $infor{$i}){
			print "$infor{$i}\n";
		}
	}
}
