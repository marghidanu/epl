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

eval {
    die "Template file is missing (${template})\n"
      unless ( -e $template );

    my $args = {};
    if ( defined($data) ) {
        die "Data file is missing ($data)\n"
          unless ( -e $data );
        $args = decode_json( path($data)->slurp() );
    }

    say Mojo::Template->new( vars => 1 )->render_file( $template, $args );
};

say "Error: $@"
  if ($@);

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
