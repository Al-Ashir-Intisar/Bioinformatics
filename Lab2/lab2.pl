# Open the files with appropriate filenames
open(my $file1, '<', 'Z2exon.txt') or die "Cannot open Z2exon.txt: $!";
open(my $file2, '<', 'Z2intron.txt') or die "Cannot open Z2intron.txt: $!";

# Read the contents of the files into arrays
my @exon = <$file1>;
my @intron = <$file2>;

# Close the files when done
close($file1);
close($file2);

# Turn arrays into scalar strings and remove whitespace
my $exon_s = join('', @exon);
my $intron_s = join('', @intron);
$exon_s =~ s/\s//g;
$intron_s =~ s/\s//g;

# Define the CpG pattern
my $cpg_pattern = 'CG';

# Calculate the expected and observed counts for exons and introns separately
my $total_bases_exon = length($exon_s);
my $total_bases_intron = length($intron_s);

my $expected_cpg_count_exon = ($total_bases_exon - 1) * ($exon_s =~ s/$cpg_pattern//g) / $total_bases_exon;
my $expected_cpg_count_intron = ($total_bases_intron - 1) * ($intron_s =~ s/$cpg_pattern//g) / $total_bases_intron;

my $observed_cpg_count_exon = ($exon_s =~ s/$cpg_pattern//g);
my $observed_cpg_count_intron = ($intron_s =~ s/$cpg_pattern//g);

# Calculate the percentages for exons and introns
my $expected_cpg_percentage_exon = ($expected_cpg_count_exon / $total_bases_exon) * 100;
my $expected_cpg_percentage_intron = ($expected_cpg_count_intron / $total_bases_intron) * 100;

my $observed_cpg_percentage_exon = ($observed_cpg_count_exon / $total_bases_exon) * 100;
my $observed_cpg_percentage_intron = ($observed_cpg_count_intron / $total_bases_intron) * 100;

# Calculate the ratios of observed to expected CpG sites for exons and introns
my $cpg_ratio_exon = $observed_cpg_count_exon / $expected_cpg_count_exon;
my $cpg_ratio_intron = $observed_cpg_count_intron / $expected_cpg_count_intron;

# Print the results for exons
print "Exons:\n";
print "Expected CpG Count: $expected_cpg_count_exon\n";
print "Observed CpG Count: $observed_cpg_count_exon\n";
print "Expected CpG Percentage: $expected_cpg_percentage_exon%\n";
print "Observed CpG Percentage: $observed_cpg_percentage_exon%\n";
print "Observed/Expected CpG Ratio: $cpg_ratio_exon\n";

# Print the results for introns
print "\nIntrons:\n";
print "Expected CpG Count: $expected_cpg_count_intron\n";
print "Observed CpG Count: $observed_cpg_count_intron\n";
print "Expected CpG Percentage: $expected_cpg_percentage_intron%\n";
print "Observed CpG Percentage: $observed_cpg_percentage_intron%\n";
print "Observed/Expected CpG Ratio: $cpg_ratio_intron\n";
