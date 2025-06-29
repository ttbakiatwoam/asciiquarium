package Asciiquarium::Environment;

=head1 NAME

Asciiquarium::Environment - Environment management for Asciiquarium

=head1 DESCRIPTION

This module handles environment setup including water surface, seaweed,
and castle elements for the aquarium.

=cut

use strict;
use warnings;
use Asciiquarium::Config;
use Asciiquarium::AsciiArt;

our $VERSION = '1.3';

=head1 SUBROUTINES

=head2 add_environment($anim)

Sets up the water surface environment.

=cut

sub add_environment {
    my ($anim) = @_;

    # Import depth values for backward compatibility
    my %depth = %Asciiquarium::Config::DEPTH_VALUES;

    my @water_line_segment = (
        q{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~},
        q{^^^^ ^^^  ^^^   ^^^    ^^^^      },
        q{^^^^      ^^^^     ^^^    ^^     },
        q{^^      ^^^^      ^^^    ^^^^^^  }
    );

    # tile the segments so they stretch across the screen
    my $segment_size = length($water_line_segment[0]);
    my $segment_repeat = int($anim->width() / $segment_size) + 1;
    foreach my $i (0 .. $#water_line_segment) {
        $water_line_segment[$i] = $water_line_segment[$i] x $segment_repeat;
    }

    foreach my $i (0 .. $#water_line_segment) {
        $anim->new_entity(
            name          => "water_seg_$i",
            type          => "waterline",
            shape         => $water_line_segment[$i],
            position      => [ 0, $i + 5, $depth{'water_line' . $i} ],
            default_color => 'cyan',
            depth         => 22,
            physical      => 1,
        );
    }
}

=head2 add_castle($anim)

Adds an animated castle to the aquarium.

=cut

sub add_castle {
    my ($anim) = @_;

    # Import depth values for backward compatibility
    my %depth = %Asciiquarium::Config::DEPTH_VALUES;

    # Use the full castle art from the original
    my @castle_image = @Asciiquarium::AsciiArt::CASTLE_ART;
    my @castle_mask = @Asciiquarium::AsciiArt::CASTLE_MASK;

    $anim->new_entity(
        name          => "castle",
        shape         => \@castle_image,
        auto_trans    => 1,
        color         => \@castle_mask,
        position      => [ $anim->width() - 32, $anim->height() - 13, $depth{'castle'} ],
        callback_args => [ 0, 0, 0, 0.1],
        default_color => 'white',
    );
}

=head2 add_all_seaweed($anim)

Adds multiple seaweed plants to the aquarium.

=cut

sub add_all_seaweed {
    my ($anim) = @_;
    
    # figure out how many seaweed to add by the width of the screen
    my $seaweed_count = int($anim->width() / 15);
    for (1 .. $seaweed_count) {
        add_seaweed(undef, $anim);
    }
}

=head2 add_seaweed($old_seaweed, $anim)

Adds a single seaweed plant to the aquarium.

=cut

sub add_seaweed {
    my ($old_seaweed, $anim) = @_;

    # Import depth values for backward compatibility
    my %depth = %Asciiquarium::Config::DEPTH_VALUES;

    my @seaweed_image = ('', '');
    my $height = int(rand(4)) + 3;
    for my $i (1 .. $height) {
        my $left_side = $i % 2;
        my $right_side = !$left_side;
        $seaweed_image[$left_side] .= "(\n";
        $seaweed_image[$right_side] .= " )\n";
    }
    my $x = int(rand($anim->width() - 2)) + 1;
    my $y = $anim->height() - $height;
    my $anim_speed = rand(.05) + .25;
    
    $anim->new_entity(
        name          => 'seaweed' . rand(1),
        shape         => \@seaweed_image,
        position      => [ $x, $y, $depth{'seaweed'} ],
        callback_args => [ 0, 0, 0, $anim_speed ],
        die_time      => time() + int(rand(4 * 60)) + (8 * 60), # seaweed lives for 8 to 12 minutes
        death_cb      => \&add_seaweed,
        default_color => 'green',
    );
}

1;

__END__

=head1 AUTHOR

Original Asciiquarium by Kirk Baucom
Refactored Environment module for improved maintainability

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut