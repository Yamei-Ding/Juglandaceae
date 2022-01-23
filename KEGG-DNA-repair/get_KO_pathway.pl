use strict;
use warnings;
sub help{
	print "perl xxx.pl allgene_KO.list ko00001.keg\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my %infor;
	while(<IN>){
		chomp;
		my @it = split(/\t/,$_);
		push @{$infor{$it[0]}},$it[1];
	}
	close(IN);
	open(IN,"$ARGV[1]") or die;
	my %term;
	while(<IN>){
		chomp;
		my @it = split(/\;/,$_);
		$term{$it[0]} = $it[1];
	}
	close(IN);
	foreach my $i(sort keys %infor){
		foreach my $k(@{$infor{$i}}){
			foreach my $j(sort keys %term){
				if($j =~ /$i/){
					print "$i\t$k\t$term{$j}\n";
				}else{
					next;
				}
			}
		}
	}
}
