use strict;
use warnings;
sub help{
	print "perl xxx.pl Orthogroup.txt \n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my $n = 0;
	while(<IN>){
		chomp;
		if(/^Orthogroup/){
			my @it = split(/\t/,$_);
			splice(@it,0,1);
			splice(@it,-1,1);
			my $line = join(" ",@it);
			print " $line\n";	
		}else{
			my @it = split(/\t/,$_);
			$n++;
			splice(@it,0,1);
			splice(@it,-1,1);
			my $line = join(" ",@it);
			print "$n $line\n";	
		}
	}
	close(IN);
}
