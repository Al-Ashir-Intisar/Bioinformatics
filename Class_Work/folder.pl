open(file1, FFF);
@newFile = <file1>;
close file1;

foreach my $line (@newFile) {
    print $line, "\n";
}

#print @newFile, "\n";

#pop shift scalar join && || unless (\s~white space and new lines) 

$x = 3;
if ($x == 4 || $x > 4){
    print "Works!\n";
}
else {
    print "Doesn't work!\n"
}


$data = "Why not you?";
$motif = "yu?";

if($data =~ $motif){
    print $motif, "\n";
}
else{
    print "doesn't work";
}