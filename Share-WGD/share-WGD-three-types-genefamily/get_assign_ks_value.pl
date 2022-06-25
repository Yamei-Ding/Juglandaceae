use strict;
use warnings;
sub help{
	print "perl xxx.pl Rch_Aro.ks  value1 value2\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my %ks;
	while(<IN>){
		chomp;
		my @it = split(/\t/,$_);
		push @{$ks{$it[0]}{$it[2]}},$it[1];
	}	
	close(IN);
	my $value1 = $ARGV[1];
	my $value2 = $ARGV[2];
	foreach my $i(sort keys %ks){
		my %tmp = %{$ks{$i}};
		my $n = 0;
		my $branch = 0;
		foreach my $j(sort keys %tmp){
			foreach my $k(@{$tmp{$j}}){
				$branch++;
				if($k >= $value1 && $k <= $value2){
					$n++;
				}
			}
		}
		if($n == 4 && $branch == 4){
			print "$i\n";
		}
		if($n == 2 && $branch == 2){
			print "$i\n";
		}
	}
}
