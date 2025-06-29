package Asciiquarium::Config;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(get_depth_config get_version get_help_message get_fish_config get_animation_config);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 NAME

Asciiquarium::Config - Configuration settings for Asciiquarium

=head1 DESCRIPTION

This module provides configuration constants and settings for the Asciiquarium
application, including depth layers, version information, and help text.

=head1 FUNCTIONS

=head2 get_depth_config()

Returns a hash reference containing the Z-depth configuration for different
elements in the aquarium.

=cut

sub get_depth_config {
    return {
        # GUI elements (top layer)
        guiText     => 0,
        gui         => 1,

        # Under water elements
        shark       => 2,
        fish_start  => 3,
        fish_end    => 20,
        seaweed     => 21,
        castle      => 22,

        # Water line elements (surface)
        water_line3 => 2,
        water_gap3  => 3,
        water_line2 => 4,
        water_gap2  => 5,
        water_line1 => 6,
        water_gap1  => 7,
        water_line0 => 8,
        water_gap0  => 9,
    };
}

=head2 get_fish_config()

Returns configuration for fish behavior and appearance.

=cut

sub get_fish_config {
    return {
        colors => ['c', 'C', 'r', 'R', 'y', 'Y', 'b', 'B', 'g', 'G', 'm', 'M'],
        min_speed => 0.25,
        max_speed => 2.25,
        bubble_chance => 3,  # 3% chance per frame
        max_swim_height => 9,
    };
}

=head2 get_animation_config()

Returns general animation and timing configuration.

=cut

sub get_animation_config {
    return {
        seaweed_density => 15,     # pixels per seaweed
        seaweed_min_height => 3,
        seaweed_max_height => 7,
        seaweed_min_lifespan => 480,  # 8 minutes in seconds
        seaweed_max_lifespan => 720,  # 12 minutes in seconds
        seaweed_min_speed => 0.25,
        seaweed_max_speed => 0.30,
    };
}

=head2 get_version()

Returns the current version string.

=cut

sub get_version {
    return "1.3";
}

=head2 get_help_message()

Returns the help message text.

=cut

sub get_help_message {
    return 'Asciiquarium is an aquarium/sea animation in ASCII art.
Enjoy the mysteries of the sea from the safety of your own terminal!

Options:
  -c --classic      Only show species from Asciiquarium 1.0
  -t --transparent  Transparent background
  -s --screensaver  Exit on any keypress
  -h --help         Print help and exit
  -v --version      Print version and exit

Hotkeys:
  q  quit
  r  redraw
  p  pause';
}

1;

__END__

=head1 AUTHOR

Original by Kirk Baucom <kbaucom@schizoid.com>
Refactored for modular design.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut