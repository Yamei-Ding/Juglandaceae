#!/usr/bin/perl -w
use strict;
sub help
{
	print "perl xxx.pl orthofinder_file anno_file path_ks\n";
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	my($orth,$kegg,$ks)=@ARGV;
	open(IN,$orth)or die "1$!\n";
	my %OG;
	while(<IN>)
	{
		if(/^(OG\S*?):\s(.*)/s)
		{
			my $num=split(" ",$2);
			if($num == 1)
			{
				$OG{"$1(SingleCopy)"}=$2;
			}
			else
			{
				$OG{$1}=$2;
			}
		}
	}
	close(IN);

	open(IN,$kegg)or die "2$!\n";
	my %kegg;
	while(<IN>)
	{
			chomp;
			my @t=split/\t/;
			$t[1] =~ s/\.1//g;
			$t[1] =~ s/\.t/\_t/g;
			$t[1] =~ s/-RA//g;
			$kegg{$t[1]}=$t[2];
	}
	close(IN);

	my %kegg_OG;
	foreach my $g(keys %kegg)
	{
		foreach my $og(keys %OG)
		{
			$OG{$og} =~ s/\.1//g;
			$OG{$og} =~ s/\.t/\_t/g;
			$OG{$og} =~ s/-RA//g;
			if($OG{$og} =~/$g\s/s)
			{
				if(exists $kegg_OG{$og})
				{
					$kegg_OG{$og}.="\t$g";
				}
				else
				{
					$kegg_OG{$og}=$g;
				}
			}
		}
	}

	my $files=`ls $ks`;
	my @files=split("\n",$files);
	my %ks;
	my %gtype;
	foreach my $file(@files)
	{
		open(IN,"$ks/$file")or die "$!\n";
		while(<IN>)
		{
			chomp;
			next if(/^>/);
			s/-RA//g;
			my @t=split /\t/;
			$ks{"$t[0]-$t[1]"}="$t[3]\/$t[4]\/$t[5]";
		#	$gtype{"$t[0]-$t[1]"}=$t[5];
			$ks{"$t[1]-$t[0]"}="$t[3]\/$t[4]\/$t[5]";
		#	$gtype{"$t[1]-$t[0]"}=$t[5];
		}
		close(IN);
	}

	printf  "%25s%5s%5s%5s%5s%5s\n","Jre","Jsi","Plst","Cca","Esp","Rch";
	my ($alljre,$alljsi,$allcca,$allrch,$allbpe,$allcfa,$allore,$allochi,$allceq,$allmru,$allqlo,$allplst,$allodav,$allesp)=(0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	foreach (sort keys %kegg_OG)
	{
		my ($jre,$jsi,$cca,$rch,$bpe,$cfa,$ore,$ochi,$ceq,$mru,$qlo,$plst,$esp,$odav)=(0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		my $gs=$kegg_OG{$_};
		my @gs=split("\t",$gs);
		foreach my $g(sort @gs)
		{
			if($g =~/^OF/){$jsi++;$alljsi++;}
			elsif($g=~/^Jr/){$jre++;$alljre++;}
			elsif($g=~/^CCA/){$cca++;$allcca++;}
			elsif($g=~/^RCH/){$rch++;$allrch++;}
			elsif($g=~/^Bpe/){$bpe++;$allbpe++;}
			elsif($g=~/^Cfa/){$cfa++;$allcfa++;}
			elsif($g=~/^Omu/){$ochi++;$allochi++;}
			elsif($g=~/^Ore/){$ore++;$allore++;}
			elsif($g=~/^CCG/){$ceq++;$allceq++;}
			elsif($g=~/^QL/){$qlo++;$allqlo++;}
			elsif($g=~/^PLST/){$plst++;$allplst++;}
			elsif($g=~/^ESP/){$esp++;$allesp++;}
			elsif($g=~/^Od/){$odav++;$allodav++;}
			else{$mru++;$allmru++;}
	#		elsif($g=~/^QL/){$qlo++;$allqlo++}
			#elsif($g=~/^CJ/){$mr++;$allmr++;}
			#else{$cfa++;$allcfa++;}
		}
		printf "%-22s%2s%5s%5s%5s%5s%5s\n",$_,$jre,$jsi,$plst,$cca,$esp,$rch;
	}
	printf "%-22s%2s%5s%5s%5s%5s%5s\n","all",$alljre,$alljsi,$allplst,$allcca,$allesp,$allrch;
	print "\n=============================================================================\n\n";
	foreach (sort keys %kegg_OG)
	{
		print ">$_\n";
		my $gs=$kegg_OG{$_};
		my @gs=split("\t",$gs);
		foreach my $g(sort @gs)
		{
			my @t=split("",$g);
			print "\t$g:$kegg{$g}\n";
			foreach my $gg(keys %kegg)
			{
				my $gpair="$g-$gg";
				if(exists $ks{$gpair})
				{
				#	if($gtype{$gpair} =~/(WGD|PD|TD)/)
				#	{
						print "\t\t".":ks_$gpair:".$ks{$gpair}."\n";
				#		print "\t\t"":ks_$gpair:".$ks{$gpair}."\n";
				#		print "\t\t:""ks_$gpair:".$ks{$gpair}."\n";
				#	}
				}
			}
		}
	}
}
