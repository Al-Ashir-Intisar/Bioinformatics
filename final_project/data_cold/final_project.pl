open(FH1, '>cold_blooded.xlsx');
open(FH2, '>cold_blooded.txt');

# List of GenBank files
my @genbank_files = (
    'Agkistrodon contortrix.gb', 'Ambystoma mexicanum.gb', 'Crocodylus niloticus.gb', 'Eublepharis macularius.gb', 'Iguana iguana.gb', 'Python regius.gb', 
    'Trachemys scripta elegans.gb', 'Aldabrachelys gigantea.gb', 'Boa constrictor.gb', 'Crocodylus rhombifer.gb', 'Geochelone elegans.gb',
     'Ophiophagus hannah.gb', 'Sphenodon punctatus.gb', 'Varanus salvator.gb', 'Alligator mississippiensis.gb', 'Chlamydosaurus kingii.gb', 
     'Crotalus adamanteus.gb', 'Heloderma suspectum.gb', 'Pogona vitticeps.gb', 'Teratoscincus keyserlingii.gb'
);

print FH1 "file_name\tGenus\tSpecies\ttype\tmtDNA_size\tmtDNA\n";
foreach my $genbank_file (@genbank_files) {
    # Build the full path to the file
    my $full_path = "$genbank_file";

    open(GB, $full_path);

    while (my $record = IRS(GB)) {
        my ($Genus, $Species, $Genome_size, $mtDNA) = separate($record);

        if ($Genus && $Species && $Genome_size) {
            print FH1 "$full_path\t$Genus\t$Species\tcold_blooded\t$Genome_size\t$mtDNA\n";
            print FH2 "$mtDNA\n\n";
        }
    }

    close(GB);
}

close(FH1);
close(FH2);
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
    my ($mtDNA) = ($record =~ /ORIGIN\s+(.*)\n\n/s);
    $mtDNA =~ s/[\d\s]//g;
    return ($genus, $species, $genome_size, $mtDNA);
}
