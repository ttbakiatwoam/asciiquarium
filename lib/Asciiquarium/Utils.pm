package Asciiquarium::Utils;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(rand_color center);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 NAME

Asciiquarium::Utils - Utility functions for Asciiquarium

=head1 DESCRIPTION

This module provides common utility functions used throughout the
Asciiquarium application.

=head1 FUNCTIONS

=head2 rand_color($color_mask)

Applies random colors to a color mask string, replacing digits with
random color codes.

=cut

sub rand_color {
    my ($color_mask) = @_;
    
    # Available colors for fish and other entities
    my @colors = ('c', 'C', 'r', 'R', 'y', 'Y', 'b', 'B', 'g', 'G', 'm', 'M');
    
    # Replace numbered positions in color mask with random colors
    $color_mask =~ s/1/$colors[int(rand(@colors))]/gm;
    $color_mask =~ s/2/$colors[int(rand(@colors))]/gm;
    $color_mask =~ s/3/$colors[int(rand(@colors))]/gm;
    $color_mask =~ s/5/$colors[int(rand(@colors))]/gm;
    $color_mask =~ s/6/$colors[int(rand(@colors))]/gm;
    $color_mask =~ s/7/$colors[int(rand(@colors))]/gm;
    $color_mask =~ s/8/$colors[int(rand(@colors))]/gm;
    
    return $color_mask;
}

=head2 center($width, $message)

Centers a message within a given width, returning the centered string.

=cut

sub center {
    my ($width, $message) = @_;
    my $length = length($message);
    
    if ($length >= $width) {
        return $message;
    }
    
    my $padding = int(($width - $length) / 2);
    return (' ' x $padding) . $message;
}

1;

__END__

=head1 AUTHOR

Refactoring team.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut