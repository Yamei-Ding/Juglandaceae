use warnings;
use strict;
sub help
{
	print "perl xxx.pl collinearity_file >new_collinearity_files\n";
	print "note: maybe the first(second) line genes don't belong to one species\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
#open(OUT,">$ARGV[]")or die "$!\n";
while (<>){
	chomp;
	next if (/^###/ or /^#\s/);
	if (/^##\sAlignment\s(\d+):.*?e_value=(\S+)\s.*?N=\d+\s(.*)\&(.*)\s/){
		print ">block$1\t$2\t$3\t$4\n";
	}
	elsif(/^.*?:\s+(\S+)\s+(\S+)\s+(.*)/)
	{
		#print OUT "$1\t$2\t$3\n";	
		print "$1\t$2\t$3\n";	
	}
}
#close(OUT);
=cut
open(IN,"ttt")or die "$!\n";
my ($sp1,$sp2);
my $num=0;
while(<IN>)
{
	if(/^>/)
	{
		print;
	}
	else
	{
		$num++;
		if($num==1)
		{
			/^(..)\S*\t(..)\S*/;
			($sp1,$sp2)=($1,$2);
			print;
		}
		elsif(/^$sp1/)
		{
			print;
		}
		elsif(/^($sp2\S*)\t($sp1\S*)\t(.*)/)
		{
			print "$2\t$1\t$3";
		}
	}
	
}
close(IN);
`rm ttt`;
=cut
}
