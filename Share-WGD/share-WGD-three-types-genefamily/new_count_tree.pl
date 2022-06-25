#!/usr/bin/perl -w
use strict;
use package;
sub help
{
	print "Usage:\n    perl xxx.pl sp1name sp2name int PATH_of_trees perl-match-treename\n";
	print "Parameters:\n    sp1name(sp2name): node name prefix of tree\n";
	print "    int: tree support level\n";
	print "    perl-match-treename: get trees that meet perl-match in PATH_of_trees. e.g. '.*reroot'\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
my ($sp1name,$sp2name,$level,$PATH,$match)=@ARGV;
my @aa_bb=();
my @ab_ab=();
my @aabb=();
my @bbaa=();
my @abab=();
my @baba=();
my @aa_b=();
my @ab_a=();
my @bb_a=();
my @ab_b=();
my $level_num=0;
my $allnum=0;
my $trees=`ls $PATH`;
foreach ((split("\n",$trees)))
{
	if(/$match/ && -f "$PATH/$_" &&  !-z "$PATH/$_")
	{
		$allnum++;
		my @nodes=split/\n/,`nw_labels $PATH/$_`;
		my $i=grep {/^\d*$/ && $_>=$level}@nodes;
		my $www = @nodes;
		if($i == 2 && $www == 7)
		{
			$level_num++;
			my $line=`nw_topology $PATH/$_`;
			$line=~s/\)\d*/\)/g;
			#aa_bb
			if($line=~/\(\($sp1name[^()]*?,$sp1name[^()]*?\),\(/ || $line=~/\(\($sp2name[^()]*?,$sp2name[^()]*?\),\(/)
			{push(@aa_bb,$_);}
			#ab_ab
			elsif($line=~/\(\($sp1name[^()]*?,$sp2name[^()]*?\),\(/ ||$line=~/\(\($sp2name[^()]*?,$sp1name[^()]*?\),\(/)
			{push(@ab_ab,$_);}
			#bbaa,have excluded aa_bb
			elsif($line=~/\($sp1name[^()]*?,$sp1name[^()]*?\)\)/ || $line=~/\(\($sp1name[^()]*?,$sp1name[^()]*?\)/ )
			{push(@bbaa,$_);}
			#aabb,have excluded aa_bb
			elsif($line=~/\($sp2name[^()]*?,$sp2name[^()]*?\)\)/ || $line=~/\(\($sp2name[^()]*?,$sp2name[^()]*?\)/)
			{push(@aabb,$_);}
			#baba
			elsif($line=~/\($sp1name[^()]*?,\($sp2name[^()]*?,$sp1name[^()]*?\)\)/ || $line=~/\($sp1name[^()]*?,\($sp1name[^()]*?,$sp2name[^()]*?\)\)/ || $line=~/\(\($sp1name[^()]*?,$sp2name[^()]*?\),$sp1name[^()]*?\)/ || $line=~/\(\($sp2name[^()]*?,$sp1name[^()]*?\),$sp1name[^()]*?\)/)
			{push(@baba,$_);}
			#abab
			elsif($line=~/\($sp2name[^()]*?,\($sp2name[^()]*?,$sp1name[^()]*?\)\)/ || $line=~/\($sp2name[^()]*?,\($sp1name[^()]*?,$sp2name[^()]*?\)\)/ || $line=~/\(\($sp1name[^()]*?,$sp2name[^()]*?\),$sp2name[^()]*?\)/ || $line=~/\(\($sp2name[^()]*?,$sp1name[^()]*?\),$sp2name[^()]*?\)/)
			{push(@abab,$_);}
			#check
			else {print "$_ ";}
		}
		elsif($i == 1 && $www == 5){
			$level_num++;
			my $line=`nw_topology $PATH/$_`;
			$line=~s/\)\d*/\)/g;
			#aa_b
			if($line=~/\($sp2name[^()]*?,\($sp1name[^()]*?,$sp1name[^()]*?\)\)/ || $line=~/\(\($sp1name[^()]*?,$sp1name[^()]*?\),$sp2name[^()]*?\)/){
				push @aa_b,$_;
			}
			#ab_a
			elsif($line=~/\($sp1name[^()]*?,\($sp1name[^()]*?,$sp2name[^()]*?\)\)/ || $line=~/\($sp1name[^()]*?,\($sp2name[^()]*?,$sp1name[^()]*?\)\)/ || $line=~/\(\($sp1name[^()]*?,$sp2name[^()]*?\),$sp1name[^()]*?\)/ || $line=~/\(\($sp2name[^()]*?,$sp1name[^()]*?\),$sp1name[^()]*?\)/){
				push @ab_a,$_;
			}
			#bb_a
			elsif($line=~/\($sp1name[^()]*?,\($sp2name[^()]*?,$sp2name[^()]*?\)\)/ || $line=~/\(\($sp2name[^()]*?,$sp2name[^()]*?\),$sp1name[^()]*?\)/){
				push @bb_a,$_;
			}
			#ab_b
			elsif($line=~/\($sp2name[^()]*?,\($sp1name[^()]*?,$sp2name[^()]*?\)\)/ || $line=~/\($sp2name[^()]*?,\($sp2name[^()]*?,$sp1name[^()]*?\)\)/ || $line=~/\(\($sp1name[^()]*?,$sp2name[^()]*?\),$sp2name[^()]*?\)/ || $line=~/\(\($sp2name[^()]*?,$sp1name[^()]*?\),$sp2name[^()]*?\)/){
				push @ab_b,$_;
			}else{
				print "$_\n";
			}
		}else{
			#print "$_\tbed\n";
			next;
		}
	}
}
print "$allnum\nall:$level_num\n(($sp1name,$sp1name),($sp2name,$sp2name)):".@aa_bb."\n@aa_bb\n(($sp1name,$sp2name),($sp1name,$sp2name)):".@ab_ab."\n@ab_ab\n($sp1name,($sp1name,($sp2name,$sp2name))):".@aabb."\n@aabb\n($sp2name,($sp2name,($sp1name,$sp1name))):".@bbaa."\n@bbaa\n($sp1name,($sp2name,($sp1name,$sp2name))):".@abab."\n@abab\n($sp2name,($sp1name,($sp2name,$sp1name))):".@baba."\n@baba\n(($sp1name,$sp1name),$sp2name):".@aa_b."\n@aa_b\n(($sp1name,$sp2name),$sp1name):".@ab_a."\n@ab_a\n(($sp2name,$sp2name),$sp1name):".@bb_a."\n@bb_a\n(($sp1name,$sp2name),$sp2name):".@ab_b."\n@ab_b\n";
}
