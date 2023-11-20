#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use XML::Simple;

# API endpoint URL
my $api_url = 'https://jsonplaceholder.typicode.com/posts';

# Create a user agent object
my $ua = LWP::UserAgent->new;

# Make a GET request to the API
my $response = $ua->get($api_url);

# Check if the request was successful
if ($response->is_success) {
    # Decode JSON response
    my $posts = decode_json($response->decoded_content);

    # Process and print the data
    foreach my $post (@$posts) {
        print "Post ID: $post->{id}\n";
        print "Title: $post->{title}\n";
        print "Body: $post->{body}\n";
        print "-----------\n";
    }
} else {
    # Print the error message if the request was not successful
    die "Error: " . $response->status_line;
}
