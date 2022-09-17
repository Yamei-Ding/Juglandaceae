#!/usr/bin/perl -w
use strict;
use Getopt::Std;
my %opt;
&getopt("c:g:r:m:o:h",\%opt);
if(!exists $opt{c} || !exists $opt{g} || !exists $opt{r} || !exists $opt{o} || !exists $opt{m})
{
        print "perl xxx.pl -c collinearity.file -g ref.gff -r SD.partition -m model [0/1] -o output_file\n";
		print "model: 0:use the collinearity genes in ref genome\n       1:use all the gene in ref genome\n";
        exit;
}

my %SD;
open (SD,$opt{r})or die;
while(<SD>)
{
        /(\S*)\s*(\S*)/;
        $SD{$1}="D";
        $SD{$2}="S";
}
close(SD);

my %syn;
open (COL,$opt{c})or die;
$/="\n## Alignment";
while(<COL>)
{
        if(/\sN=\d*\s*Qlo\d*&(\S*).*?\n(.*)/s || /\sN=\d*\s\s*(\S\S*)&Qlo\d*.*?\n(.*)/s)   
        {   
                chomp;
                my ($sub_chr,$col)=($SD{$1},$2);
                my @lines=split/\n/,$col;
                foreach my $l(@lines)
                {   
                        if($l=~/\s(Qlo\S*)/)
                        {   
                                $syn{$1}{$sub_chr}=1;
                        }   
                }   
        }   
}
close(COL);
$/="\n";

my %gene_sort;
open (GFF,$opt{g})or die;
while(<GFF>)
{
	my @t=split/\t/,;
	$gene_sort{$t[0]}{$t[1]}=$t[2];
}
close(GFF);

my %retain;
print "ref_chr\tref_gene\tD\tS\tboth\n";
foreach my $chr(sort keys %gene_sort)
{
	my %gene_info=%{$gene_sort{$chr}};
	foreach my $gene(sort{$gene_info{$a}<=>$gene_info{$b}} keys %gene_info)
	{
		my $bool ="T";
		if($opt{m} == 0)
		{
			if(!exists $syn{$gene}{"D"} && !exists $syn{$gene}{"S"}){$bool="F";}
		}
		if($bool eq "T")
		{
			print "$chr\t$gene\t";
			my $if;
			if(exists $syn{$gene}{"D"}){$if="1";}else{$if="0";}
			$retain{$chr}{"D"}.=$if;
			print "$if\t";
			if(exists $syn{$gene}{"S"}){$if="1";}else{$if="0";}
			$retain{$chr}{"S"}.=$if;
			print "$if\t";
			if(exists $syn{$gene}{"D"} && exists $syn{$gene}{"S"}){$if="1";}else{$if="0";}
			$retain{$chr}{"both"}.=$if;
			print "$if\n";
		}
	}
}

open (OUT,">$opt{o}")or die;
print OUT "ref_chr\tpos\tretain_rate\tlabel\n";
foreach my $chr (keys %retain)
{
	my $text_D=$retain{$chr}{"D"};
	my $text_S=$retain{$chr}{"S"};
	my $text_both=$retain{$chr}{"both"};
	my ($sub_text,$num,$rate);
	for(my $i=0;$i+100<=length($text_D);$i+=10)
	{
		$sub_text=substr($text_D,$i,100);
		$num=($sub_text=~tr/1//);
		$rate=$num/100;
		print OUT "$chr\t$i\t$rate\tD\n";
		$sub_text=substr($text_S,$i,100);
		$num=($sub_text=~tr/1//);
		$rate=$num/100;
		print OUT "$chr\t$i\t$rate\tS\n";
		$sub_text=substr($text_both,$i,100);
		$num=($sub_text=~tr/1//);
		$rate=$num/100;
		print OUT "$chr\t$i\t$rate\tboth\n";
	}
}
