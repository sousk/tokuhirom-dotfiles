#!/usr/local/bin/perl
use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize;

my @url = qw(
    http://64p.org/
    http://inamode.64p.org/
    http://64p.org/nopaste/
    http://64p.org/menta/
    http://64p.org/newmo/
    http://64p.org/memo/
);

my $mech = Test::WWW::Mechanize->new();
$mech->get_ok($_) for @url;

done_testing;
