open(FH1, '>all_data.xlsx');
open(FH2, '>warm_blooded.txt');

# List of GenBank files
my @genbank_warm_files = (
    'Acinonyx jubatus.gb', 'Canis lupus.gb', 'Felis catus.gb', 'Megaptera novaeangliae.gb', 'Panthera tigris.gb', 'Spheniscus humboldti.gb', 
    'Ailurus fulgens.gb', 'Carcharodon carcharias.gb', 'Gorilla gorilla gorilla.gb', 'Mirounga angustirostris.gb', 'Panthera uncia.gb', 
    'Tursiops truncatus.gb', 'Aptenodytes forsteri.gb', 'Ceratotherium simum.gb', 'Gorilla gorilla.gb', 'Ornithorhynchus anatinus.gb', 
    'Phascolarctos cinereus.gb', 'Ursus arctos.gb', 'Balaenoptera musculus.gb', 'Chelonia mydas.gb', 'Haliaeetus leucocephalus.gb', 
    'Oryctolagus cuniculus.gb', 'Physeter macrocephalus.gb', 'Ursus maritimus.gb', 'Bison bison.gb', 'Equus caballus.gb', 'Loxodonta africana.gb', 
    'Oryx leucoryx.gb', 'Psittacus erithacus.gb', 'Vulpes vulpes.gb', 'Bos taurus.gb', 'Equus zebra.gb', 'Lynx canadensis.gb', 'Pan paniscus.gb', 
    'Puma concolor.gb', 'Canis lupus familiaris.gb', 'Falco peregrinus.gb', 'Macaca mulatta.gb', 'Pan troglodytes.gb', 'Sarcophilus harrisii.gb'
);

my @genbank_cold_files = (
    'Agkistrodon contortrix.gb', 'Boa constrictor.gb', 'Crotalus adamanteus.gb', 'Hemidactylus frenatus.gb', 'Physignathus cocincinus.gb', 'Sphenodon punctatus.gb',
'Aldabrachelys gigantea.gb', 'Chelydra serpentina.gb', 'Danio rerio.gb', 'Iguana iguana.gb', 'Poecilia reticulata.gb', 'Teratoscincus keyserlingii.gb',
'Alligator mississippiensis.gb', 'Chlamydosaurus kingii.gb', 'Eublepharis macularius.gb', 'Malacochersus tornieri.gb', 'Pogona vitticeps.gb', 'Trachemys scripta elegans.gb',
'Ambystoma laterale.gb', 'Coreius heterodon.gb', 'Gavialis gangeticus.gb', 'Oncorhynchus mykiss.gb', 'Python regius.gb', 'Varanus salvator.gb',
'Ambystoma mexicanum.gb', 'Crocodylus niloticus.gb', 'Geochelone elegans.gb', 'Ophiophagus hannah.gb', 'Salamandra salamandra.gb', 'Xenopus laevis.gb',
'Andrias japonicus.gb', 'Crocodylus rhombifer.gb', 'Heloderma suspectum.gb', 'Phyllobates terribilis.gb', 'Salmo salar.gb'

);


print FH1 "file_name\tGenus\tSpecies\ttype\tmtDNA_size\ttRNA_starts\ttRNA_ends\trRNA_starts\trRNA_ends\tCDS_starts\tCDS_ends\tCDS_string\tmtDNA\n";
foreach my $genbank_warm_files (@genbank_warm_files) {
    # Build the full path to the file
    my $full_path = "data_warm/$genbank_warm_files";

    open(GB, $full_path);

    while (my $record = IRS(GB)) {
        my ($Genus, $Species, $Genome_size, $mtDNA, $tRNA_starts, $tRNA_ends, $rRNA_starts, $rRNA_ends, $CDS_starts, $CDS_ends, $CDS_string) = separate($record);

        if ($Genus && $Species && $Genome_size && $mtDNA) {
            print FH1 "$full_path\t$Genus\t$Species\twarm\t$Genome_size\t$tRNA_starts\t$tRNA_ends\t$rRNA_starts\t$rRNA_ends\t$CDS_starts\t$CDS_ends\t$CDS_string\t$mtDNA\n";
        }
    }

    close(GB);
}

foreach my $genbank_cold_files (@genbank_cold_files) {
    # Build the full path to the file
    my $full_path = "data_cold/$genbank_cold_files";

    open(GB, $full_path);

    while (my $record = IRS(GB)) {
        my ($Genus, $Species, $Genome_size, $mtDNA, $tRNA_starts, $tRNA_ends, $rRNA_starts, $rRNA_ends, $CDS_starts, $CDS_ends, $CDS_string) = separate($record);

        #print $CDS_string, "\n";

        if ($Genus && $Species && $Genome_size && $mtDNA) {
            print FH1 "$genbank_cold_files\t$Genus\t$Species\tcold\t$Genome_size\t$tRNA_starts\t$tRNA_ends\t$rRNA_starts\t$rRNA_ends\t$CDS_starts\t$CDS_ends\t$CDS_string\t$mtDNA\n";
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

    my $CDS_string;
    while ($record =~ /translation="([^"]*)"/sg) {
        my $string = $1;
        $string =~ tr/A-Za-z//cd;
        $string = $string . '+';
        #print $string, "\n";
        $CDS_string = $CDS_string . $string;  
        
        #print "CDS start: $start, CDS end: $end\n";
    }
    
    $CDS_string =~ tr/\s//d;
    #print $CDS_string, "\n";

    my $CDS_starts = join('+', @CDS_starts);
    my $CDS_ends = join('+', @CDS_ends);

    #print @tRNA_starts, "\n"; #@tRNA_ends, "\n", @rRNA_starts, "\n", @rRNA_ends, "\n", @CDS_starts, "\n", @CDS_ends, "\n";

    return ($genus, $species, $genome_size, $mtDNA, $tRNA_starts, $tRNA_ends, $rRNA_starts, $rRNA_ends, $CDS_starts, $CDS_ends, $CDS_string);
}
