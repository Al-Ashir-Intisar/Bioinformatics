open(FH1, '>out.xls');

# List of GenBank files
my @genbank_files = (
    'cape_golden_mole.gb', 'philippine_flying_lemur.gb', 'sunda_flying_lemur.gb',
    'benin_tree_hyrax.gb', 'rock_hyrax.gb', 'western_tree_hyrax.gb',
    'brown_throated_sloth.gb', 'giant_anteater.gb', 'pale_throated_sloth.gb',
    'silky_anteater.gb', 'two_toed_sloth.gb', 'borean_smooth_tailed_tree_shrew.gb',
    'common_tree_shrew.gb', 'madras_tree_shrew.gb', 'northern_tree_shrew.gb',
    'slender_tree_shrew.gb'
);

# List of GenBank files with corresponding order names
my %order_mapping = (
    'cape_golden_mole.gb' => 'Chrysochloridae',
    'philippine_flying_lemur.gb' => 'Dermopetra',
    'sunda_flying_lemur.gb' => 'Dermopetra',
    'benin_tree_hyrax.gb' => 'Hydracoidea',
    'rock_hyrax.gb' => 'Hydracoidea',
    'western_tree_hyrax.gb' => 'Hydracoidea',
    'brown_throated_sloth.gb' => 'Pilosa',
    'giant_anteater.gb' => 'Pilosa',
    'pale_throated_sloth.gb' => 'Pilosa',
    'silky_anteater.gb' => 'Pilosa',
    'two_toed_sloth.gb' => 'Pilosa',
    'borean_smooth_tailed_tree_shrew.gb' => 'Scandentia',
    'common_tree_shrew.gb' => 'Scandentia',
    'madras_tree_shrew.gb' => 'Scandentia',
    'northern_tree_shrew.gb' => 'Scandentia',
    'slender_tree_shrew.gb' => 'Scandentia'
);

foreach my $genbank_file (@genbank_files) {
    open(GB, $genbank_file);

    while (my $record = IRS(GB)) {
        my ($Genus, $Species, $Genome_size) = separate($record);
        #print "$Genus, $Species, $Genome_size";

        # Get the order name from the mapping
        my $Order = $order_mapping{$genbank_file};

        if ($Genus && $Species && $Order && $Genome_size) {
            print FH1 "$genbank_file\t$Order\t$Genus\t$Species\t$Genome_size\n";
        }
    }

    close(GB);
}

close(FH1);

sub IRS {
    my ($fg) = @_;
    local $/ = "//\n\n";  # Use local to avoid changing the global $/
    my $record = <$fg>;
    return $record;
}

sub separate {
    my ($record) = @_;
    
    my ($genus, $species) = ($record =~ /ORGANISM\s+(\w+)\s+(\w+)/s);
    my ($genome_size) = ($record =~ /LOCUS\s+\S+\s+(\d+)\s+bp/s);
    
    return ($genus, $species, $genome_size);
}
