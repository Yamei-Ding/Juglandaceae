use strict;
use warnings;
sub help{
	print "pelr xxx.pl gene.list KEGG_KO_term.list\n";
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
		my @it = split(/\t/,$_);
		$infor{$it[1]} = $_;
	}
	close(IN);
	my %count;
	foreach my $i(@gene){
		if(exists $infor{$i}){
			my @it = split(/\t/,$infor{$i});
			$count{$it[2]}++;
			print STDERR "$infor{$i}\n";
		}else{
			next;
		}
	}
	foreach my $i(sort {$count{$b} <=> $count{$a}} keys %count){
		print "$i\t$count{$i}\n";
	}
}
