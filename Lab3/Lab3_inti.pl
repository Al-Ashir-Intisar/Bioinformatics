
#reading the dna sequence from the file
open(my $file1, '<', 'macaqueMHC.txt');
my @sequence = <$file1>;

#cleaning the sequence
my $dna_sequence = join('', @sequence);
$dna_sequence =~ s/\s//g;
print "\nDNA sequence retrieved from the file: \n$dna_sequence \n";

#take input 5`UTR from user
print "\nEnter 5`UTR sequence (strings other than the bases i.e. ACGT/acgt will be removed): ";
my $utr_sequence = <STDIN>;
$utr_sequence =~ s/\s//g;
$utr_sequence = uc($utr_sequence);
$utr_sequence =~ tr/ACTG//cd;
print "Your input is : $utr_sequence \n";

#subrutine to concatenate 
sub concatenate{
    ($st1, $st2) = @_;
    my $mod = $st1 . $st2;
    return $mod;
}
my $mod_sequence = &concatenate($utr_sequence, $dna_sequence);


#subrutine for new start codon position 
sub start_cdn{
    my $st1 = "@_";
    my $pos;
    if ($st1 =~ /ATG/) {
        my $position = $-[0]; # Get the start position of the match
        $pos = $position+1;
    } else {
        $pos = length($st1)+1;
    }

    return $pos;

}
my $start_cdn_pos = &start_cdn($utr_sequence);
print "\nNew position of the start codon is base number $start_cdn_pos from the start of the modified sequence below:\n\n";

#printing the modified dna sequence
print $mod_sequence, "\n\n";

#checking whether or not the reading frame has shifted
my $guard = ((length($utr_sequence) - $start_cdn_pos)+1)%3;
#print "guard $guard \n\n";
if($start_cdn_pos == length($utr_sequence)+1){
    print "The reading frame has not shifted.\n\n";
} elsif( $guard == 0){
    print "The reading frame has not shifted.\n\n";
}
else{
    print "The reading frame has shifted.\n\n";
}

