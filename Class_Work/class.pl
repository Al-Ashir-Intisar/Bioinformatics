# $st = 3;
# while($st < 10000){
#     $st = ($st*2);
#     print "$st\n";
# }

# cytocine to thymine (methylation)
# CpG sites C more likely to convert to T 

# print "Enter a number: \n";
# $number = <STDIN>;
# print "The number is ", $number, "\n";

# open(FH, '>new.txt');
# print FH "Yayyyyyyy!!!";

# open(FH, 'Z2exon.txt');


# @exon = <FH>;
# close(FH);
# $exon_joined = join('', @exon);

# $exon_joined =~ s/\s//g;

# open(modFH, '>Z2exon.txt');

# print modFH $exon_joined;
# close(modFH);

# &printWelcome;

# sub printWelcome{

#     print "Welcome to IntiLand";
# }
use module;
$DNA = "CGTAGGTACCGAA";
$DNA1 = "CGTA";

print &chop2($DNA1, $DNA);



