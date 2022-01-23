use warnings;
use strict;

sub help
{
	print "perl xxx.pl 1->2.blast 2->1.blast >out\n";
	print "the outfile first and second cols' order is same as 1->2.blast\n";
}
sub readDB()
{
	my $file = shift;
	my %db;
	my %com;
	open IN,$file or die "Can't open $file in readDB\n";
	while (<IN>)
	{
		chomp;
		my $line = $_;
		my @it = split /\t/,$line;
		if (!exists $com{$it[0]} && $it[0] ne $it[1])
		{
			$com{$it[0]} = $it[10];
			$db{$it[0]}{$it[1]} = $line;
		}	
	}
	close IN;
	return \%db;
}

if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	my ($db,$query) = @ARGV;
	my $db_hash = &readDB($db);
	my $query_hash = &readDB($query);

	foreach my $aa (sort keys %{$db_hash})
	{
		my $flag = 0;
		my @tmp1 = (keys %{$db_hash->{$aa}});
		my $tmp1 = $tmp1[0];
		if (exists $$query_hash{$tmp1}->{$aa})
		{
			$flag = 1;
			print "$db_hash->{$aa}{$tmp1}\n";
		}
	}
}
