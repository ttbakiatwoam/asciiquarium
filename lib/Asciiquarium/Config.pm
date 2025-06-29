package Asciiquarium::Config;

use strict;
use warnings;
use JSON;
use Carp qw(croak);

=head1 NAME

Asciiquarium::Config - Configuration management for Asciiquarium

=head1 SYNOPSIS

    use Asciiquarium::Config;
    
    my $config = Asciiquarium::Config->new();
    my $depth = $config->get_depth('fish_start');
    my $ascii_art = $config->get_ascii_art('castle');

=head1 DESCRIPTION

This module manages configuration and ASCII art data for Asciiquarium,
extracting hardcoded values from the main script into external JSON files.

=cut

our $VERSION = '1.3';

sub new {
    my ($class, %args) = @_;
    
    my $data_dir = $args{data_dir} || _find_data_dir();
    
    my $self = {
        data_dir => $data_dir,
        config => undef,
        ascii_art => undef,
    };
    
    bless $self, $class;
    $self->_load_config();
    return $self;
}

sub _find_data_dir {
    # Look for data directory relative to script location
    my @possible_paths = (
        './data',
        '../data', 
        '/usr/share/asciiquarium/data',
        '/usr/local/share/asciiquarium/data'
    );
    
    for my $path (@possible_paths) {
        return $path if -d $path;
    }
    
    croak "Could not find data directory. Searched: " . join(', ', @possible_paths);
}

sub _load_config {
    my ($self) = @_;
    
    my $config_file = $self->{data_dir} . '/config.json';
    my $ascii_file = $self->{data_dir} . '/ascii_art.json';
    
    $self->{config} = $self->_load_json_file($config_file);
    $self->{ascii_art} = $self->_load_json_file($ascii_file);
}

sub _load_json_file {
    my ($self, $file) = @_;
    
    open my $fh, '<', $file or croak "Cannot read $file: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    
    return decode_json($content);
}

=head2 get_depth($name)

Get depth configuration for rendering layers.

=cut

sub get_depth {
    my ($self, $name) = @_;
    return $self->{config}->{depths}->{$name};
}

=head2 get_depths()

Get all depth configurations as a hash reference.

=cut

sub get_depths {
    my ($self) = @_;
    return $self->{config}->{depths};
}

=head2 get_config($section, $key)

Get a configuration value from a specific section.

=cut

sub get_config {
    my ($self, $section, $key) = @_;
    return $key ? $self->{config}->{$section}->{$key} : $self->{config}->{$section};
}

=head2 get_ascii_art($name)

Get ASCII art data by name.

=cut

sub get_ascii_art {
    my ($self, $name) = @_;
    return $self->{ascii_art}->{$name};
}

=head2 get_colors()

Get the list of available colors for entities.

=cut

sub get_colors {
    my ($self) = @_;
    return @{$self->{config}->{colors}};
}

1;

__END__

=head1 AUTHOR

Asciiquarium Contributors

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut