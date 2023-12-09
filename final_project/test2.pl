open(FH1, '>out.xls');

# List of GenBank files
my @genbank_files = (
    'Acinonyx jubatus.gb', 'Canis lupus.gb', 'Felis catus.gb', 'Pan troglodytes.gb', 'Tursiops truncatus.gb', 'Aptenodytes forsteri.gb', 'Equus caballus.gb',
    'Gorilla gorilla.gb', 'Ursus arctos.gb', 'Bos taurus.gb', 'Equus zebra.gb', 'Loxodonta africana.gb', 'Physeter macrocephalus.gb', 
    'Ursus maritimus.gb', 'Canis lupus familiaris.gb', 'Falco peregrinus.gb', 'Megaptera novaeangliae.gb', 'Psittacus erithacus.gb', 'Vulpes vulpes.gb'
);

print FH1 "file_name\tGenus\tSpecies\tmtDNA_size\ttRNA_starts\ttRNA_ends\trRNA_starts\trRNA_ends\tCDS_starts\tCDS_ends\tmtDNA\n";

my $full_path = "/workspaces/Bioinformatics/final_project/data_warm/Acinonyx jubatus.gb";

open(GB, $full_path);

while (my $record = IRS(GB)) {
    my ($Genus, $Species, $Genome_size, $mtDNA, $tRNA_starts, $tRNA_ends, $rRNA_starts, $rRNA_ends, $CDS_starts, $CDS_ends) = separate($record);

    if ($Genus && $Species && $Genome_size && $mtDNA) {
        print FH1 "$full_path\t$Genus\t$Species\t$Genome_size\t$tRNA_starts\t$tRNA_ends\t$rRNA_starts\t$rRNA_ends\t$CDS_starts\t$CDS_ends\t$mtDNA\n";
    }
}

close(GB);

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
    my ($mtDNA) = ($record =~ /ORIGIN\s+(.*)\/\/\n\n/s);
    $mtDNA =~ s/[\d\s]//g;
    
    my @tRNA_starts;
    my @tRNA_ends;

    while ($record =~ /tRNA\s+(\d+)\.\.(\d+)/sg) {
        my ($start, $end) = ($1, $2);
        push(@tRNA_starts, $start);
        push(@tRNA_ends, $end);
        #print "tRNA start: $start, tRNA end: $end\n";
    }

    my $tRNA_starts = join('+', @tRNA_starts); 
    my $tRNA_ends = join('+', @tRNA_ends);

    my @rRNA_starts;
    my @rRNA_ends;
    while ($record =~ /rRNA\s+(\d+)\.\.(\d+)/sg) {
        my ($start, $end) = ($1, $2);
        push(@rRNA_starts, $start);
        push(@rRNA_ends, $end);
        #print "rRNA start: $start, rRNA end: $end\n";
    }
    my $rRNA_starts = join('+', @rRNA_starts);
    my $rRNA_ends = join('+', @rRNA_ends);

    my @CDS_starts;
    my @CDS_ends;
    while ($record =~ /CDS\s+(\d+)\.\.(\d+)/sg) {
        my ($start, $end) = ($1, $2);
        push(@CDS_starts, $start);
        push(@CDS_ends, $end);
        #print "CDS start: $start, CDS end: $end\n";
    }

    my $CDS_starts = join('+', @CDS_starts);
    my $CDS_ends = join('+', @CDS_ends);

    #print @tRNA_starts, "\n"; #@tRNA_ends, "\n", @rRNA_starts, "\n", @rRNA_ends, "\n", @CDS_starts, "\n", @CDS_ends, "\n";

    return ($genus, $species, $genome_size, $mtDNA, $tRNA_starts, $tRNA_ends, $rRNA_starts, $rRNA_ends, $CDS_starts, $CDS_ends);
}
