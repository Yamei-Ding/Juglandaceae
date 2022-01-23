use strict;
use warnings;
sub help{
	print "pelr xxx.pl genename.list esterid.list\n";
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
		my @it = split(/\s/,$_);
		my $num = @it;
		if($num == 2){
			$infor{$it[1]} = $it[0];
		}
	}
	close(IN);
	foreach my $i(@gene){
		if(exists $infor{$i}){
			print "$infor{$i}\t$i\n";
		}else{
			next;
		}
	}
}
