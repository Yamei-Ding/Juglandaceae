use strict;
use warnings;
sub help{
	print "perl xxx.pl output\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	while(<IN>){
		chomp;
		if(/^OG/){
			my @it = split(/\s+/,$_);
			my $n = 0;
			foreach my $i(1 .. 6){
				if($it[$i] == 2 && $it[7] <= 1){
					$n++;
				}	
			}
			if($n <=6 && $n >= 1){
				print "$_\n";
			}
		}else{
			next;
		}
	}
	close(IN);
}
