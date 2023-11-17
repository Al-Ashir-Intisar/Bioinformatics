#use module;

sub rand_base_sequence{
    (my $size, my $Apct, my $Cpct, my $Gpct, my $Tpct) = @_;
    my $rand_num = rand(100);
    my $base;

    if($rand_num < $Apct){
        $base = "A";
    }
    elsif($rand_num >= $Apct && $rand_num < ($Apct + $Cpct)){
        $base = "C";
    }
    elsif($rand_num >= ($Apct + $Cpct) && $rand_num < ($Apct + $Cpct + $Gpct)){
        $base = "G";
    }
    elsif($rand_num >= ($Apct + $Cpct + $Gpct) && $rand_num < ($Apct + $Cpct + $Gpct + $Tpct)){
        $base = "T";
    }
    #print $rand_num, "  ", $base;
    return $base;
}



sub generate_dna{
    (my $size, my $count) = @_;
    my $dna;
    my @dna_set;

    for($i = 0 ; $i < $count; ++$i){
        for ($index = 0; $index < $size; ++$index){
            $dna.=&rand_base_sequence(100, 31, 19, 19, 31);

        }

    push(@dna_set, $dna);
    #print $dna, "\n";
    $dna = "";
    }


    return @dna_set;
    
}



sub complementary_strand{
    my $sequence = "@_";
    #print $sequence, "\n";
    my $antisense_strand = reverse $sequence;
    $antisense_strand =~ tr/ACGT/UGCA/;
    #print $antisense_strand, "\n";
    return $antisense_strand;
}

sub check_ORF{
    (my $sequence, my $reading_frame) = @_;
    my $size = length($sequence);
    my $stop_codon = "UAG";
    my $count = 0;
    #my $no_stop_codon = 1;
    for(my $i = $reading_frame; $i < $size; $i+=3){
        my $codon = substr($sequence, $i, 3);
        #print $codon, "  ";
        if($codon ne $stop_codon){
            $count++;
            #print $count, " ";
            #print $i, "\n";
            #print $codon, " ";
            #$no_stop_codon = 0;
            if($count > 200){
                #print $count, " ";
                #$count = 0;
                return 1;
            }

        }
        else{
            $count = 0;
        }

    }   
    return 0;
}

my $size = 1000;
my $iteration = 100000;
my @array_sequence = &generate_dna($size, $iteration);
my @array_complementary_sequence;
my $occurance_count = 0;

for(my $i = 0; $i < $iteration; $i++){
    my $dna = $array_sequence[$i];
    #print $dna, "\n";
    my $reverse_dna = &complementary_strand($dna);
    #print $reverse_dna, "\n";
    push(@array_complementary_sequence, $reverse_dna);
}


for(my $j = 0; $j < $iteration; $j++){
    for(my $i = 0; $i < 3; $i++){
        my $value = &check_ORF($array_complementary_sequence[$j], $i);
        #print $value, " ";
        #print $value, " ";
        if($value == 1){
            $i = 3;
            $occurance_count++;
            #$j++;

        }


    }
}

print "Percent of ORF>200 AA found in $iteration antisense strand with 38% GC content is " ,100*$occurance_count/$iteration, "%. \n";
