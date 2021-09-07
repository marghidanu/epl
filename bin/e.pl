#!/usr/bin/env perl

use Mojo::Base -strict;
use Mojo::Util qw(extract_usage getopt);
use Mojo::File qw(path);
use Mojo::JSON qw(decode_json);
use Mojo::Template;

getopt(
    'd|data=s' => \my $data,
    'h|help'   => \my $help,
);

die extract_usage() if ( $help || !( my $template = shift ) );

my $output =
  Mojo::Template->new()->vars(1)
  ->render_file( $template,
    defined($data) ? decode_json( path($data)->slurp() ) : {} );

print $output;

__END__

=encoding utf8

=head1 NAME

epl-cli - EPL templating CLI tool

=head1 SYNOPSIS

    Usage: e.pl [OPTIONS] [TEMPLATE]

    Options:
        -d, --data <json file>  Path to the JSON file.
        -h, --help              Print this message       

=head1 DESCRIPTION

CLI tool for rendeding EPL templates.

=cut
