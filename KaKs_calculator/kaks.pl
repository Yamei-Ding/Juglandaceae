#!/usr/bin/perl -w
use strict;

sub help
{	
	print "perl xxx.pl gpair_file file_format(0:collinearity-format / 1:gene1\\tgene2\\n / 2:gene1\\tgene2...\\n / 3.syn-format) cds.file pep.file new.gpair.kaks\n";
	print "the output maybe delete some gpair because their cds-seq and pep_seq are inconsitent\n";
}

if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	 my $id=int(rand(100000000));
	 system "echo 20 >$id.proc";
	 system "rm -rf $ARGV[0].output";
	 if($ARGV[1] == 0)
	 {
		open(IN,$ARGV[0])or die "$!\n";
		open(OUT,">./$id.tttttt")or die "$!\n";
		while(<IN>)
		{
			unless(/^#/)	
			{
				my @t=split("\t");
				print OUT "$t[1]\t$t[2]\n";
			}
		}
		close(IN);
		close(OUT);
		system "ParaAT.pl -h $id.tttttt -n $ARGV[2] -a $ARGV[3] -p $id.proc -o $ARGV[0].output -f axt";	
	 }
	 elsif($ARGV[1] == 2 || $ARGV[1] == 3)
	 {
		open(IN,$ARGV[0])or die "$!\n";
		open(OUT,">./$id.tttttt")or die "$!\n";
		while(<IN>)
		{
			unless(/^>/)	
			{
				my @t=split("\t");
				print OUT "$t[0]\t$t[1]\n";
			}
		}
		close(IN);
		close(OUT);
		system "ParaAT.pl -h $id.tttttt -n $ARGV[2] -a $ARGV[3] -p $id.proc -o $ARGV[0].output -f axt";
	 }
	 elsif($ARGV[1] == 1)
	 {
		system "ParaAT.pl -h $ARGV[0] -n $ARGV[2] -a $ARGV[3] -p $id.proc -o $ARGV[0].output -f axt";
	 }
	 else
	 {
	 	die "error input\n";
	 }
	system "cat $ARGV[0].output/* > $id.axt";
	system "KaKs_Calculator -i $id.axt -o $id.tttkaks -m GMYN";
	system "rm -r $ARGV[0].output && rm $id.proc && rm -f $id.tttttt";
	my %kaks;
	open(IN,"./$id.tttkaks")or die "$!\n";
	while(<IN>)
	{
		my @t=split /\t/;
		if($t[4] eq "NA" && $t[3] !~ /NA/){$t[4]=~s/NA/0/;}
		$t[2]=~s/NA/0/;
		$t[3]=~s/NA/0/;
		$kaks{$t[0]}="$t[2]\t$t[3]\t$t[4]";
	}
	close(IN);

	open(IN,$ARGV[0])or die "$!\n";
	open(OUT,">$ARGV[4]")or die "$!\n";
	while(<IN>)
	{
		if(/^#/ || /^>/)	
		{
			print OUT;
		}
		else
		{
			chomp;
			my @t=split/\t/;
			if($ARGV[1] == 0)
			{
				if(exists $kaks{"$t[1]-$t[2]"})
				{
					my $kaks=$kaks{"$t[1]-$t[2]"};
					print OUT "$_\t$kaks\n";
				}
			}
			if($ARGV[1] == 1 || $ARGV[1] ==2 ||  $ARGV[1] == 3)
			{
				if(exists $kaks{"$t[0]-$t[1]"})
				{
					my $kaks=$kaks{"$t[0]-$t[1]"};
					print OUT "$_\t$kaks\n";
				}
			}
		}
	}
	close(IN);
	close(OUT);
#	system "rm $id.axt && rm $id.tttkaks";
}
