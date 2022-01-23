#!/usr/bin/perl -w
use strict;
use package;

sub help
{
	print "perl xxx.pl treelist path_tree\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	my $trees=&read_list($ARGV[0]);
	foreach(@{$trees})
	{
		open(IN,"$ARGV[1]/$_")or die "$!\n";
		while(<IN>)
		{
		#(((A,B),(A,B)),C) || (C,(A,B),(A,B)))
		/\(([^()]*?):[^()]*?,([^()]*?):.*?\((\S*?):.*?,(\S*?):/;
		print "$1\t$2\n";
		print "$1\t$3\n";
		print "$1\t$4\n";
		print "$2\t$3\n";
		print "$2\t$4\n";
		print "$3\t$4\n";
		}
		close(IN);
	}
}
