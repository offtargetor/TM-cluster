use strict;
open IN,$ARGV[0];
my %hash;
my $cluster=0;
my $f;
while(<IN>){
	chomp;
	my @A=split/\s+/,$_;
	if(!exists $hash{$A[0]} && $f ne $A[0]){
		$cluster++;
		print "\n$cluster\t$A[0]";
		$f=$A[0];
		$hash{$A[0]}=1;
		next;
	}
	if($f eq $A[0] && !exists $hash{$A[1]}){
		print "\t$A[1]";
		$hash{$A[1]}=1;
	}
}
close IN;
