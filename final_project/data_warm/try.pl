# Initialize arrays for starts and ends
my @starts = (1, 5, 10);
my @ends = (3, 8, 13);

# Create a list using references to the arrays
my $list = { start => \@starts, end => \@ends };

# Access the list elements
print "Starts: ", join(", ", @{$list->{start}}), "\n";
print "Ends: ", join(", ", @{$list->{end}}), "\n";
