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
			my $n = 0;
			#foreach my $i(1 .. 5){
				if($it[$col] == 2 && $it[7] <= 1){
					print "$_\n";
				}
		}else{
			next;
		}
	}
	close(IN);
}
