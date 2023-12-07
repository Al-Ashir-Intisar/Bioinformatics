use strict;
use warnings;

# Specify the path to your text file
my $file_path = 'warm_blooded.txt';

my @sequence_array;
# Open the file for reading
open my $fh, '<', $file_path or die "Cannot open file: $!";

# Read the file content
local $/ = "\n\n";  # Set input record separator to two newlines
my $length = 0;
# Read and print mtDNA sequences until the end of file
while (my $mt_dna_sequence = <$fh>) {
    chomp $mt_dna_sequence;  # Remove trailing newline
    $mt_dna_sequence =~ s/[\/\/]//g;
    push(@sequence_array, $mt_dna_sequence);
    $length = $length+1;
    #print "mtDNA Sequence:\n$mt_dna_sequence\n\n";
}

my $sequence = $sequence_array[2];
if ($sequence =~ /atg/g) {
        #my $coding_length = length($sequence);
        #print "Coding Region:\t$coding_length\n$sequence\n";
        print pos($sequence);
    } else {
        print "Non-Coding Region:\n$sequence\n";
    }

#print "$length \n @sequence_array[0] \n";
# Close the file
close $fh;
