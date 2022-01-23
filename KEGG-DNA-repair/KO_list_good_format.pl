use strict;
use warnings;
sub help{
	print "pelr xxx.pl Rch_KO.list \n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	while(<IN>){
		chomp;
		my @it = split(/\t/,$_);
		my $num = @it;
		if($num == 2){
			print "$it[1]\t$it[0]\n";
		}
	}
	close(IN);
}
