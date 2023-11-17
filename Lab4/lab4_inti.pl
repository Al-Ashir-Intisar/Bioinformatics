
sub rand_base{
    my @base_array = ("A", "C", "T", "G") ;
    my $index = int(rand(4));
    my $base = $base_array[$index];

    return $base;

}
sub rand_biased_base{
    my @biased_bases = ("T", "T","A", "A", "A", "A", "T", "T", "C", "G");
    my $index = int(rand(10));
    my $base = $biased_bases[$index];
}

sub generate_dna{
    (my $size, my $count, my $function) = @_;
    my $dna;
    my @dna_set;

    if($function eq "even"){
        for($i = 0 ; $i < $count; ++$i){
        for ($index = 0; $index < $size; ++$index){
            $dna.=&rand_base;

        }

        push(@dna_set, $dna);
        $dna = "";
        }
    }
    elsif($function eq "biased"){
        for($i = 0 ; $i < $count; ++$i){
        for ($index = 0; $index < $size; ++$index){
            $dna.=&rand_biased_base;

        }

        push(@dna_set, $dna);
        $dna = "";

        }
    }
    return @dna_set;
    
}

sub mutate_dna{
    (my $dna_sqnc, my $function) = @_;
    if($function eq "even"){
        my $size = length($dna_sqnc);
        my $index = int(rand($size));
        my $base = &rand_base;
        substr($dna_sqnc, $index, 1, $base);


    }
    elsif($function eq "biased"){
        my $size = length($dna_sqnc);
        my $index = int(rand($size));
        my $base = &rand_biased_base;
        substr($dna_sqnc, $index, 1, $base);


    }
    return $dna_sqnc;

}

sub match_dna{
    (my $sqnc_1, my $sqnc_2) = @_;
    my $length_1 = length($sqnc_1);
    my $length_2 = length($sqnc_2);
    my $count = 0;

    if($length_1 != $length_2){
        print "Different sizes of dna sequence. Enter same size sequences.\n";
        return;
    }
    for(my $i = 0; $i < $length_1; ++$i){
        if(substr($sqnc_1, $i, 1) eq substr($sqnc_2, $i, 1)){
            ++$count;
            #print $i, "\n";
        }
    }
    return $count;

}



my $iteration_count = 10000;
my $sqnc_size = 100;

my @even_array = &generate_dna($sqnc_size, $iteration_count, "even");
my @biased_array = &generate_dna($sqnc_size, $iteration_count, "biased");

my $even_count_generation = 0;
my $biased_count_generation = 0;
my $even_avg_gen;
my $biased_avg_gen;

for(my $i = 0; $i < $iteration_count; $i++){
    my $match_percent = 100;
    my $dna1_to_mutate = $even_array[$i];
    my $dna2_to_mutate = $even_array[$i];

    
    while($match_percent > 50){
        $dna1_to_mutate = &mutate_dna($dna1_to_mutate, "even");
        $dna2_to_mutate = &mutate_dna($dna2_to_mutate, "even");
        $match_percent = &match_dna($dna1_to_mutate, $dna2_to_mutate);
        $even_count_generation++;
    }
    

}

for(my $i = 0; $i < $iteration_count; $i++){
    my $match_percent = 100;
    my $dna1_to_mutate = $biased_array[$i];
    my $dna2_to_mutate = $biased_array[$i];

    
    while($match_percent > 50){
        $dna1_to_mutate = &mutate_dna($dna1_to_mutate, "biased");
        $dna2_to_mutate = &mutate_dna($dna2_to_mutate, "biased");
        $match_percent = &match_dna($dna1_to_mutate, $dna2_to_mutate);
        $biased_count_generation++;
    }
    

}

$even_avg_gen = $even_count_generation/$iteration_count;
$biased_avg_gen = $biased_count_generation/$iteration_count;



print "Average generation required for evenly distributed DNA sequence to reach 50% divergence is ", $even_avg_gen, ".\n","Average generation required for unevenly distributed DNA sequence to reach 50% divergence is ", $biased_avg_gen, ".\n";


print "Looks like a uneven nucleotide distribution slows down the molecular clock.\n";


