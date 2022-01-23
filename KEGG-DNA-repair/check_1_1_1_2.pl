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
		next if(/^Orth/);
		if(/^OG/){
			my @it = split(/\s+/,$_);
			my $n = 0;
			foreach my $i(1 .. 6){
				if($it[$i] == 1 && $it[7] == 2){
					$n++;
				}	
			}
			if($n == 6){
				print "$_\n";
			}
		}else{
			next;
		}
	}
	close(IN);
}
