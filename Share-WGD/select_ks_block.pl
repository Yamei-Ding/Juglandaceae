#!/usr/bin/perl -w
use strict;

sub help
{
	print "perl xxx.pl syn_file ks proportion\n";
	print "Screen blocks that has at least proportion of gene pairs which ks is less than ks_value\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
$/=">";
open(IN,$ARGV[0])or die "$!\n";
while(<IN>)
{
    chop;
    if(/^(block\d+)\t\S+\t(\S+)\t(\S+).*?\n(.*)/s)
    {   
        my($block,$chr1,$chr2)=($1,$2,$3);
        my ($allks,$goodks)=(0,0);
        my @pairs=split ("\n",$4);
        foreach my $line (@pairs)
        {   
            my @t=split("\t",$line);    
            $allks++;
			$t[4]=~s/NA/10/;
            if( $t[4] <$ARGV[1] ){$goodks++;}
        }   
        if($goodks/$allks > $ARGV[2])
		{
			print ">$_";
		}
	}
}
close(IN);
$/="\n";
}
