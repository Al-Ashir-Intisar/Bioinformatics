
open(file1, Z1DNA4);
open(file2, Z1DNA1);
open(file3, Z1DNA2);
$Z1DNA4 = <file1>;
$Z1DNA1 = <file2>;
$Z1DNA2 = <file3>;

$com_dna4 = reverse $Z1DNA4;
$com_dna4 =~ tr/AGTC/TCAG/;
$combined = $Z1DNA1 . $Z1DNA2;


$length = length($combined);
print $length, " is the length of the sequences \n";

for my $i (0..$length-1) {
        my $nucleotide1 = substr($combined, $i, 1);
        my $nucleotide2 = substr($com_dna4, $i, 1);

        if ($nucleotide1 ne $nucleotide2) {
            print $nucleotide1, " at index ", $i, " changed to ", $nucleotide2, "\n";
        }
    }

print "Both changes are transversion and both changes are pyrimidine to purine";
