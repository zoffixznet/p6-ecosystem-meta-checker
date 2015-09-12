#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use Mojo::UserAgent;
use JSON::Meth;
use List::UtilsBy qw/sort_by/;

sub body {
    my ( $tx, $message ) = @_;
    $message //= 'Network error';
    die $message . ': ' . $tx->res->message if $tx->error;
    return $tx->res->body;
};

my $eco = 'https://raw.githubusercontent.com/perl6/ecosystem/master/META.list';
my $ua = Mojo::UserAgent->new;

my @modules = split ' ', body $ua->get($eco), 'Could not fetch ecosystem';

my @errors;
for ( @modules ) {
    say "Processing $_";
    eval { (body $ua->get($_), "Could not fetch $_")->$j; 1; }
        and next;

    say "\n\n**************************\nERROR: $@\n"
                . "**************************\n\n";

    push @errors, +{
        name => $_,
        error => $@ =~ /not fetch/ ? 'Not found'
            : $@ =~ /Meth/ ? 'JSON' : 'Unknown',
    };
}

exit 0 unless @errors;
say "Found errors:";

say "JSON:";
say for map $_->{name}, grep $_->{error} eq 'JSON', @errors;

say "\n404:";
say for map $_->{name}, grep $_->{error} eq 'Not found', @errors;

say "\nUnknown:";
say for map $_->{name}, grep $_->{error} eq 'Unknown', @errors;

exit 1;

__END__