use strict;
use warnings;
sub help{
	print "perl xxx.pl genefamily.list Orthogroups.txt 1>genefamily_genename.txt \n";
	print "genefamily.list is one column\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	my @og;
	my %og;
	open(LIST,"$ARGV[0]") or die;
	while(<LIST>){
		chomp;
		push @og,$_;
	}
	close(LIST);
	open(OG,"$ARGV[1]") or die;
	while(<OG>){
		chomp;
		next if(/^Orthogroup/);
		my @it = split(/\:/,$_);
		$og{$it[0]} = $it[1];
	}
	close(OG);
	foreach my $i(@og){
		my @gene = split(/\s/,$og{$i});
		foreach my $j(@gene){
			if($j =~ /^(Jre.*)/){
		#	if($j =~ /Chr/ || $j =~ /Scaf/){
				print "$j\n";
			}
		}
	}
}
