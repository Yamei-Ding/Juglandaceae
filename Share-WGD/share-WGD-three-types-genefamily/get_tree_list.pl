use strict;
use warnings;
sub help{
	print "pelr xxx.pl dir/ prefix\n"
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	my @files = split(/\n/,`ls $ARGV[0]`);
	my $prefix = $ARGV[1];
	foreach my $file(@files){
		if($file =~ /$prefix/){
			my @tmp = split(/\./,$file);
			`rm -rf $tmp[0].list`;
			`sed -n 6p $ARGV[0]/$file >>$tmp[0].list`;
			`sed -n 18p $ARGV[0]/$file >>$tmp[0].list`;
			`sed -n 22p $ARGV[0]/$file >>$tmp[0].list`;
			#`sed -i 's/ /\n/g' $tmp[0].list`;
		}
	}
}
