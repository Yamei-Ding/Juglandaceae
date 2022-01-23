use strict;
use warnings;
sub help{
	print "perl xxx.pl output col\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my $col = $ARGV[1];
	while(<IN>){
		chomp;
		if(/^OG/){
			my @it = split(/\s+/,$_);
			if($it[$col] <= 1 && $it[7] == 2){
				print "$_\n";
			}
		}else{
			next;
		}
	}
	close(IN);
}
