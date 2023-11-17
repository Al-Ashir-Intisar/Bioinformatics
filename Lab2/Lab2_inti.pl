# Open the files with appropriate filenames
open(my $file1, '<', 'Z2exon.txt');
open(my $file2, '<', 'Z2intron.txt');

# Read the contents of the files into arrays
my @exon = <$file1>;
my @intron = <$file2>;

# Close the files when done
close($file1);
close($file2);

# turning arrays into scalars
$exon_s = join('', @exon);
$intron_s = join('', @intron);

# getting rid of characters other than the bases
$exon_s =~ s/\s//g;
$intron_s =~ s/\s//g;

#total bases in exon and intron
$exon_base_count = length $exon_s;
$intron_base_count = length $intron_s;

# variable to store nucleotide count in exon
$exon_C = 0;
$exon_G = 0;
$exon_T = 0;
$exon_A = 0;

# counting the nucleotides in exon 
for ($index = 0; $index < $exon_base_count; ++$index){
    $base = substr($exon_s, $index, 1);
    if($base eq 'C'){
        ++$exon_C;
    }
    elsif($base eq 'G'){
        ++$exon_G;
    }
    elsif($base eq 'T'){
        ++$exon_T;
    }
    elsif($base eq 'A'){
        ++$exon_A;
    }

}


# variable to count nucleotides in intron
$intron_C = 0;
$intron_G = 0;
$intron_T = 0;
$intron_A = 0;

# counting the nucleotides in intron 
for ($index = 0; $index < $intron_base_count; ++$index){
    $base = substr($intron_s, $index, 1);
    if($base eq 'C'){
        ++$intron_C;
    }
    elsif($base eq 'G'){
        ++$intron_G;
    }
    elsif($base eq 'T'){
        ++$intron_T;
    }
    elsif($base eq 'A'){
        ++$intron_A;
    }

}

#variable to store observed and expected CpG sites in exon and intron
$exp_CpG_exon = 100*($exon_C/$exon_base_count)*($exon_G/$exon_base_count);
$obsr_CpG_exon = 0;
$exp_CpG_intron = 100*($intron_C/$intron_base_count)*($intron_G/$intron_base_count);
$obsr_CpG_intron = 0;

# calculating the expected percentage of CpG sites in exon and intron
for($index = 0; $index < ($exon_base_count - 1); ++$index){
    $site = substr($exon_s, $index, 2);
    if($site eq "CG"){
        ++$obsr_CpG_exon;

    }
}

for($index = 0; $index < ($intron_base_count - 1); ++$index){
    $site = substr($intron_s, $index, 2);
    if($site eq "CG"){
        ++$obsr_CpG_intron;

    }
}

# printing the observations
print "Total bases in exon ", $exon_base_count, "\n", $exon_C, " Cytosines ", 100*($exon_C/$exon_base_count), "% \n", $exon_G, " Guanosines ", 100*($exon_G/$exon_base_count),"% \n", $exon_T, " Thymines ", 100*($exon_T/$exon_base_count),"% \n", $exon_A, " Adenines ", 100*($exon_A/$exon_base_count),"% \n\n"; 

print "Expected percentage of CpG sites in exon ", $exp_CpG_exon, "% which is ", ($exp_CpG_exon*$exon_base_count)/(2*100), " CpG sites"," \n", "Observed CpG sites in exon is ", $obsr_CpG_exon, " which is ", 100*($obsr_CpG_exon*2/$exon_base_count), "% of the total base count."," \n\n";

print "Total bases in intron ", $intron_base_count, "\n", $intron_C, " Cytosines ", 100*($intron_C/$intron_base_count), "% \n", $intron_G, " Guanosines ", 100*($intron_G/$intron_base_count),"% \n", $intron_T, " Thymines ", 100*($intron_T/$intron_base_count),"% \n", $intron_A, " Adenines ", 100*($intron_A/$intron_base_count),"% \n\n";

print "Expected percentage of CpG sites in intron is ", $exp_CpG_intron, "% which is ", ($exp_CpG_intron*$intron_base_count)/(2*100), " CpG sites"," \n", "Observed CpG sites in intron is ", $obsr_CpG_intron, " which is ", 100*($obsr_CpG_intron*2/$intron_base_count), "% of the total base count." ," \n\n";

print "The observed:expected ratio in exon is ", ($obsr_CpG_exon/(($exp_CpG_exon*$exon_base_count)/(2*100))), ".\n", "The observed:expected ratio in intron is ", ($obsr_CpG_intron/(($exp_CpG_intron*$intron_base_count)/(2*100))), ".\n";

print "\n", "We can see that the ratio is lower in exon than in intron which can be explained by: Functional Differences**: Exons and introns have different functions in the gene. Exons code for protein sequences, so they are more conserved, and mutations in exons may be less tolerated. In contrast, introns are often more variable and can accumulate mutations more readily. These mutations can create or destroy CpG sites, affecting the observed:expected ratio. **Evolutionary Conservation**: CpG sites can be evolutionarily conserved or evolve rapidly, depending on their functional significance. Exons tend to be under stronger selective pressure to maintain function, while introns may be more tolerant of sequence changes.";

