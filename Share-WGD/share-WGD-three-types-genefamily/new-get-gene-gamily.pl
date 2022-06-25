#!/usr/bin/perl -w
use strict;
use Algorithm::Combinatorics qw(combinations permutations);
use package;

sub help
{
	print "Usage:\n    perl xxx.pl sp Orthogroup.txt PATH_cds PATH_pep PATH_para_orth_to_Rch_syn PATH_newdoc\n";
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
	my($sp,$orthogroup,$PATH_cds,$PATH_pep,$PATH_syn,$PATH_newdoc)=@ARGV;
	my $syn1=&get_ks($PATH_syn);
#	my $syn2=&get_ks($PATH_orth_syn);
	my %syn=%{$syn1};
	my %groups;
	open(IN,$orthogroup)or die "$!\n";
	while(<IN>)
	{
		my @sppara=();
		my @rchpara=();
		if(/(^\S*?):.*\s$sp.*\s(Qlo\S*).*\sRch/)
		{
			my $name=$1;
			my $outgroup=$2;
			my @sp=();
			my @rch=();
			my @genes=split(" ",$_);
			my $num=0;
			grep {if(/^$sp/){$num++;push(@sp,$_)}if(/^Rch/){$num++;push(@rch,$_);}}@genes;
			print "$name: $sp:".@sp." Rch:".@rch."\n";	
			if($num >=3)
			{
				$groups{$name}="";
				#ensure paralog from WGD
				if(@sp >=2)
				{
					my @a=&combinations(\@sp,2);
					grep {my @pair=@{$_};if(exists $syn{"$pair[0]:$pair[1]"}){push(@sppara,"$pair[0]:$pair[1]");} }@a;
				}
				else{push(@sppara,"$sp[0]:#");}
				print "$sp-WGDpara: @sppara\n";
				if(@rch >=2)
				{
					my @a=&combinations(\@rch,2);
					grep {my @pair=@{$_};if(exists $syn{"$pair[0]:$pair[1]"}){push(@rchpara,"$pair[0]:$pair[1]");} }@a;
				}
				else{push(@rchpara,"$rch[0]:#");}
				print "rch-WGDpara: @rchpara\n";
				#ensure ortholog from WGD or speciation
				my %t;
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
						if(("$para1:$para2"!~/#/ && $k == 4) || ("$para1:$para2"=~/#/ && $k == 2) )
						{
							$groups{$name}.=",$para1:$para2:$outgroup";
							$t{$para1}++;
							$t{$para2}++;
						}
					}
				}
				#delte gene redundancy
				if(exists $groups{$name})
				{
					foreach (keys %t)
					{
						if($t{$_}>=2)
						{
							$groups{$name}="";
							last;
						}
					}
				}
				print "quartet: $groups{$name}\n";
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
	#MSA && constructe tree
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
				if($g=~/^Qlo/){$outg=$g;}
				if($g ne "#"){
				print CDS ">$g\n$cds{$g}\n";
				print PEP ">$g\n$pep{$g}\n";}
			}
			close(CDS);
			close(PEP);
			`linsi $PATH_newdoc/$sp/$sp-pep/$group-$num >$PATH_newdoc/$sp/$sp-pepalin/$group-$num`;
			`pal2nal.pl $PATH_newdoc/$sp/$sp-pepalin/$group-$num $PATH_newdoc/$sp/$sp-cds/$group-$num -output fasta > $PATH_newdoc/$sp/$sp-cdsalin/$group-$num`;
			# ensure gap proportion less than 50%
			my $cds_ali=&read_fa("$PATH_newdoc/$sp/$sp-cdsalin/$group-$num");
			my $boot = "T";
			foreach my $i(sort keys %{$cds_ali})
			{
				my $len = length($$cds_ali{$i});
				my $count_gap = $$cds_ali{$i} =~ tr/-//;
				if($count_gap/$len > 0.5){$boot = "F";last;}
			}
			if($boot eq "T")
			{
				`iqtree -s $PATH_newdoc/$sp/$sp-cdsalin/$group-$num -o $outg -B 10000 -m MFP --prefix $PATH_newdoc/$sp/$sp-tree/$group-$num -T 2`;
				`nw_reroot $PATH_newdoc/$sp/$sp-tree/$group-$num.treefile $outg >$PATH_newdoc/$sp/$sp-tree/$group-$num.reroot`;
			}
			}
		}
	}
}
