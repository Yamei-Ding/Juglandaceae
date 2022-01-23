use strict;
use warnings;
sub help{
	print "perl xxx.pl 6sp.repair Orthogroup.txt\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my %repair;
	while(<IN>){
		chomp;
		my @it = split(/\t/,$_);
		$repair{$it[1]} = $it[2];
	}
	close(IN);
	open(IN,"$ARGV[1]") or die;
	while(<IN>){
		chomp;
		my @it = split(/\:/,$_);
		my @tmp = split(/\s/,$it[1]);
		foreach my $i(@tmp){
			if(exists $repair{$i}){
				print "$it[0]\t$repair{$i}\n";
				last;
			}else{
				next;
			}
		}
	}	
	close(IN);
}
