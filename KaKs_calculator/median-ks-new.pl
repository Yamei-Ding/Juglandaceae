#!/usr/bin/perl -w
use strict;

sub help
{
	print "perl xxx.pl syn.ks method(0/1) > ks\n";
	print "method :median:0 / mean:1\n";
}
sub mid
{
    my @list = sort{$a<=>$b} @_;
    my $count = @list;
    if( $count == 0 )
    {
        return undef;
    }   
    if(($count%2)==1){
        return $list[int(($count-1)/2)];
    }
    elsif(($count%2)==0){
        return ($list[int(($count-1)/2)]+$list[int(($count)/2)])/2;
    }
}
sub average
{
	my @list=@_;
	my $sum=0;
	foreach(@list)
	{
		$sum+=$_;
	}
	my $num=@list;
	my $mean=$sum/$num;
	return $mean;
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	open(IN,$ARGV[0])or die "$!\n";
	$/=">";
	while(<IN>)
	{
		chomp;
		if(/^.*?\n(.*)/s){
		my @ks=split("\n",$1);
		my @block;
		foreach my $i(@ks)
		{
			#$i=~/.*\t(\S+)/;
			my @tmp = split(/\t/,$i);
			my $ks=$tmp[4];
			if($ks =~ /NA/){push(@block,0);}
			else{push(@block,$ks);}
		}
		if($ARGV[1] == 0)
		{
			my $mid=&mid(@block);
			print "$mid\n";
		}
		elsif($ARGV[1] == 1)
		{
			my $mean=&average(@block);
			print "$mean\n";
		}
		else{print "error method\n";last;}}
	}
	$/="\n";
	close(IN);
}








