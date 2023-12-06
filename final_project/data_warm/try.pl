my $genbank_content = <<'END_CONTENT';
ORIGIN      1     ggattaatga ctaatcagcc catgatcaca cataactgtg gtgtcatgca tttggtatct
END_CONTENT

# Extract the DNA sequence
if ($genbank_content =~ /ORIGIN\s+(.*)\n+/s) {
    my $dna_sequence = $1;
    $dna_sequence =~ s/\s+//g;  # Remove remaining whitespace
    print "DNA Sequence: $dna_sequence\n";
} else {
    print "DNA sequence not found in the GenBank content.\n";
}
