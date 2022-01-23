#!/usr/bin/perl -w
use strict;
use package;

sub help
{
	print "Usage:\n    perl xxx.pl sp Orthogroup.txt PATH_cds PATH_pep PATH_para_syn PATH_orth_to_Rch_syn PATH_newdoc\n";
	print "Parameters:\n    sp: the first few letters that all gene-name must have. e.g. RCH\n";   
	print "    PATH_para_syn: there are all Jualandaceae-WGD block(no gamma-WGT block)\n";
	print "    PATH_orth_to_Rch_syn: there are all first_peak block(not duplicated before(or in) gamma-WGT)\n";
	print "    PATH_newdoc: absolute path\n";
	print "Notes:\n    it maybe can't construte a tree successfully because there are some genes that their cds_seq and pep_seq are inconsistent\n";
}

sub get_ks
{	
	my($PATH_syn)=@_;
	my $files=`ls $PATH_syn`;
	my %syn;
	foreach my $f((split("\n",$files)))
	{
		if( -f "$PATH_syn/$f")
		{
			open(IN,"$PATH_syn/$f")or die "$!\n";
			while(<IN>)
			{
				unless(/>/ || /^$/)
				{
					my @t=split("\t");
					$syn{"$t[0]:$t[1]"}=$t[4];
					$syn{"$t[1]:$t[0]"}=$t[4];
				}
			}
			close(IN);
		}
	}
	return \%syn;
}
if($ARGV[0] eq "-h")
{
	&help();
}
else
{
	my($sp,$orthogroup,$PATH_cds,$PATH_pep,$PATH_syn,$PATH_orth_syn,$PATH_newdoc)=@ARGV;
	my $syn1=&get_ks($PATH_syn);
	my $syn2=&get_ks($PATH_orth_syn);
	my %syn=(%{$syn1},%{$syn2});
	my %groups;
	open(IN,$orthogroup)or die "$!\n";
	while(<IN>)
	{
		#s/\.1//g;
		#s/-RA//g;
		my @sppara=();
		my @rchpara=();
		
#		if(/(\S*?):.*?\s(CJ\S*).*?\s(Chr.*\sChr\S*).*?\s($sp.*\s$sp\S*)/)
		if(/(\S*?):.*?\s($sp.*\s$sp\S*).*?\s(Qlo\S*).*?\s(Rch.*\sRch\S*)/)
#		if(/(\S*?):.*?\s($sp.*\s$sp\S*).*?\s(CJ\S*).*?\s(Chr.*\sChr\S*)/)
#		if(/(\S*?):.*?\s(CJ\S*).*?\s(Chr.*\sChr\S*).*?\s($sp.*\s$sp\S*)/)
		{
			my $name=$1;
			$groups{$name}="";
			my @sp=split(" ",$2);
			my @rch=split(" ",$4);
			my $outgroup=$3;
			my %if;
			foreach my $sp1(@sp)
			{
				foreach my $sp2(@sp)
				{
					if($sp1 ne $sp2 && !exists $if{"$sp1:$sp2"}  && exists $syn{"$sp1:$sp2"})
					{
						push(@sppara,"$sp1:$sp2");
						$if{"$sp1:$sp2"}=$if{"$sp2:$sp1"}=1;
					}
				}
			}
			foreach my $sp1(@rch)
			{
				foreach my $sp2(@rch)
				{
					if($sp1 ne $sp2 && !exists $if{"$sp1:$sp2"} && exists $syn{"$sp1:$sp2"})
					{
						push(@rchpara,"$sp1:$sp2");
						$if{"$sp1:$sp2"}=$if{"$sp2:$sp1"}=1;
					}
				}
			}
			foreach my $para1(@sppara)
			{
				my @gs1=split(":",$para1);
				foreach my $para2(@rchpara)
				{
					my @gs2=split(":",$para2);
					my $k=0;
					if(exists $syn{"$gs1[0]:$gs2[0]"}){$k++;}
					if(exists $syn{"$gs1[0]:$gs2[1]"}){$k++;} 
					if(exists $syn{"$gs1[1]:$gs2[0]"}){$k++;}
					if(exists $syn{"$gs1[1]:$gs2[1]"}){$k++;}
					if($k >=1)
					{
						$groups{$name}.=",$para1:$para2:$outgroup";
					}
				}
			}
		}
	}
	close(IN);

	my %cds=();
	foreach my $file((split("\n",`ls $PATH_cds`)))
	{
		my $cds=&read_fa("$PATH_cds/$file");
		%cds=(%cds,%{$cds});
	}
	my %pep=();
	foreach my $file((split("\n",`ls $PATH_pep`)))
	{
		my $pep=&read_fa("$PATH_pep/$file");
		%pep=(%pep,%{$pep});
	}

	`rm -f $PATH_newdoc/$sp/$sp-pep/*`;
	`rm -f $PATH_newdoc/$sp/$sp-cds/*`;
	`rm -f $PATH_newdoc/$sp/$sp-cdsalin/*`;
	`rm -f $PATH_newdoc/$sp/$sp-pepalin/*`;
	`rm -f $PATH_newdoc/$sp/$sp-tree/*`;
	`mkdir -p $PATH_newdoc/$sp/$sp-pep`;
	`mkdir -p $PATH_newdoc/$sp/$sp-cds`;
	`mkdir -p $PATH_newdoc/$sp/$sp-cdsalin`;
	`mkdir -p $PATH_newdoc/$sp/$sp-pepalin`;
	`mkdir -p $PATH_newdoc/$sp/$sp-tree`;
	foreach my $group ( keys %groups)
	{
		my $gs=$groups{$group};
		my @k=split(",",$gs);
		my $num=0;
		foreach my $i(@k)
		{	
			if($i){
			$num++;
			open(CDS,">$PATH_newdoc/$sp/$sp-cds/$group-$num"),or die "$!\n";
			open(PEP,">$PATH_newdoc/$sp/$sp-pep/$group-$num"),or die "$!\n";
			my @gs=split(":",$i);
			my $outg;
			foreach my $g(@gs)
			{
				print CDS ">$g\n$cds{$g}\n";
				print PEP ">$g\n$pep{$g}\n";
				#if($g=~/CJ/)
				#{
				#	$outg=$g;
				#}
			}
			close(CDS);
			close(PEP);
			`linsi $PATH_newdoc/$sp/$sp-pep/$group-$num >$PATH_newdoc/$sp/$sp-pepalin/$group-$num`;
			`pal2nal.pl $PATH_newdoc/$sp/$sp-pepalin/$group-$num $PATH_newdoc/$sp/$sp-cds/$group-$num -output fasta > $PATH_newdoc/$sp/$sp-cdsalin/$group-$num`;
			#`iqtree -s $PATH_newdoc/$sp/$sp-cdsalin/$group-$num -B 10000 -m MFP --prefix $PATH_newdoc/$sp/$sp-tree/$group-$num -T 1 -o $outg`;
		#	`nw_reroot $PATH_newdoc/$sp/$sp-tree/$group-$num\.contree $outg > $PATH_newdoc/$sp/$sp-tree/$group-$num\.reroot`;
				open(FA,"$PATH_newdoc/$sp/$sp-cdsalin/$group-$num") or die;
				my %ssss;
				my $nnnn;
				while(<FA>){
					chomp;
					if(/^>(.*)/){
						$nnnn = $1;
					}else{
						$ssss{$nnnn} .= $_;
					}
				}
				close(FA);
				my $boot = "T";
				foreach my $iiii(sort keys %ssss){
					if($iiii =~ /Qlo/){
						$outg = $iiii;
					}
					my $len = length($ssss{$iiii});
					my $count_gap = $ssss{$iiii} =~ tr/-//;
					if($count_gap/$len > 0.5){
						$boot = "F";
						last;
					}
				}
				if($boot eq "T"){
					#`raxmlHPC-SSE3 -fa -x12345 -# 1000 -m GTRGAMMA -s $PATH_newdoc/$sp/$sp-cdsalin/$group-$num -p 12345 -w $PATH_newdoc/$sp/$sp-tree -n $group-$num -o $outg`;
					`iqtree -s $PATH_newdoc/$sp/$sp-cdsalin/$group-$num -o $outg -B 10000 -m MFP --prefix $PATH_newdoc/$sp/$sp-tree/$group-$num -T 2`;
					`nw_reroot $PATH_newdoc/$sp/$sp-tree/$group-$num.contree $outg >$PATH_newdoc/$sp/$sp-tree/$group-$num.reroot`
				}
			}
		}
	}
}
