#!/usr/bin/perl -w
use strict;
sub help
{
	print "perl xxx.pl blast_file num\n";
	print "num :one gene can match \$num other genes\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
my($blast_file,$num)=@ARGV;
open(IN,$blast_file)or die "$!\n";
my %gene_matchnum;
while(<IN>)
{
	if(/(.*?)\t(.*?)\t.*/){
		if($1 ne $2){
			$gene_matchnum{$1}++;	
			if($gene_matchnum{$1} <= $num){
				print "$_";
			}
		}
	}
}
close(IN);
}
