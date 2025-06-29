package Asciiquarium::Config;

=head1 NAME

Asciiquarium::Config - Configuration module for Asciiquarium

=head1 DESCRIPTION

This module contains all configuration values, constants, and settings
used throughout the Asciiquarium application, centralizing what were
previously hardcoded magic numbers and values.

=cut

use strict;
use warnings;

our $VERSION = '1.3';

=head1 CONFIGURATION VALUES

=head2 DEPTH_VALUES

Z-depth values for different visual elements in the aquarium.
Lower values appear in front of higher values.

=cut

our %DEPTH_VALUES = (
    # GUI elements (front-most)
    gui_text     => 0,
    gui          => 1,

    # Underwater elements
    shark        => 2,
    fish_start   => 3,
    fish_end     => 20,
    seaweed      => 21,
    castle       => 22,

    # Water surface elements
    water_line3  => 2,
    water_gap3   => 3,
    water_line2  => 4,
    water_gap2   => 5,
    water_line1  => 6,
    water_gap1   => 7,
    water_line0  => 8,
    water_gap0   => 9,
);

=head2 ANIMATION_SETTINGS

General animation and timing settings.

=cut

our %ANIMATION_SETTINGS = (
    # Fish movement settings
    fish_speed_min        => 0.25,
    fish_speed_range      => 2.0,
    
    # Seaweed animation settings
    seaweed_anim_speed    => 0.1,
    seaweed_lifetime_min  => 8 * 60,  # 8 minutes
    seaweed_lifetime_max  => 4 * 60,  # additional 4 minutes (total 8-12 min)
    
    # Castle animation settings  
    castle_anim_speed     => 0.1,
    
    # Bubble settings
    bubble_rise_speed     => 0.1,
    
    # Screen update timing
    screen_update_delay   => 1,  # halfdelay(1) setting
);

=head2 COLOR_SCHEMES

Available color schemes and color definitions.

=cut

our %COLOR_SCHEMES = (
    # Available colors for fish and other elements
    fish_colors => ['c', 'C', 'r', 'R', 'y', 'Y', 'b', 'B', 'g', 'G', 'm', 'M'],
    
    # Default colors for specific elements
    default_colors => {
        fish        => 'yellow',
        shark       => 'cyan', 
        castle      => 'white',
        seaweed     => 'green',
        bubble      => 'blue',
        dolphin     => 'blue',
        sword_fish  => 'yellow',
    },
    
    # Curses color mappings
    curses_colors => ['WHITE', 'RED', 'GREEN', 'BLUE', 'CYAN', 'MAGENTA', 'YELLOW', 'BLACK'],
);

=head2 ENTITY_LIMITS

Limits and ranges for various entities in the aquarium.

=cut

our %ENTITY_LIMITS = (
    # Seaweed placement
    seaweed_count         => 2,
    seaweed_height_range  => 4,
    
    # Fish placement and behavior  
    max_fish_on_screen    => 10,
    fish_bubble_chance    => 0.1,   # 10% chance to add bubble
    
    # Screen positioning
    castle_offset_x       => 32,
    castle_offset_y       => 13,
);

=head2 RANDOM_OBJECT_WEIGHTS

Probability weights for different random objects appearing.

=cut

our %RANDOM_OBJECT_WEIGHTS = (
    ship        => 1,
    whale       => 1, 
    monster     => 1,
    big_fish    => 2,
    shark       => 1,
    fishhook    => 1,
    swan        => 1,
    ducks       => 1,
    dolphins    => 1,
    submarine   => 1,
    sword_fish  => 1,
);

=head1 SUBROUTINES

=head2 get_depth_value($key)

Returns the depth value for a given key.

=cut

sub get_depth_value {
    my ($key) = @_;
    return $DEPTH_VALUES{$key} // die "Unknown depth key: $key";
}

=head2 get_animation_setting($key)

Returns an animation setting value for a given key.

=cut

sub get_animation_setting {
    my ($key) = @_;
    return $ANIMATION_SETTINGS{$key} // die "Unknown animation setting: $key";
}

=head2 get_color_scheme($scheme)

Returns a color scheme array or hash reference.

=cut

sub get_color_scheme {
    my ($scheme) = @_;
    return $COLOR_SCHEMES{$scheme} // die "Unknown color scheme: $scheme";
}

=head2 get_entity_limit($key)

Returns an entity limit value for a given key.

=cut

sub get_entity_limit {
    my ($key) = @_;
    return $ENTITY_LIMITS{$key} // die "Unknown entity limit: $key";
}

1;

__END__

=head1 AUTHOR

Original Asciiquarium by Kirk Baucom
Refactored configuration module for improved maintainability

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut