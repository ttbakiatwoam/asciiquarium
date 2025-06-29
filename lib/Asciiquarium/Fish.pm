package Asciiquarium::Fish;

=head1 NAME

Asciiquarium::Fish - Fish entity management for Asciiquarium

=head1 DESCRIPTION

This module handles fish creation, movement, and behavior in the aquarium,
consolidating the previously separate old_fish and new_fish functionality.

=cut

use strict;
use warnings;
use Asciiquarium::Config;
use Asciiquarium::AsciiArt;

our $VERSION = '1.3';

# Global variables set by main script
our $new_fish;

=head1 SUBROUTINES

=head2 set_globals(%globals)

Sets global variables from the main script.

=cut

sub set_globals {
    my %globals = @_;
    $new_fish = $globals{new_fish} // 1;
}

=head2 add_all_fish($anim)

Adds multiple fish to the animation.

=cut

sub add_all_fish {
    my ($anim) = @_;
    
    # figure out how many fish to add by the size of the screen,
    # minus the stuff above the water
    my $screen_size = ($anim->height() - 9) * $anim->width();
    my $fish_count = int($screen_size / 350);
    for (1 .. $fish_count) {
        add_fish(undef, $anim);
    }
}

=head2 add_fish($anim)

Adds a single fish to the animation, choosing between old and new fish styles.

=cut

sub add_fish {
    my ($old_fish, $anim) = @_;
    
    if ($new_fish) {
        if (int(rand(12)) > 8) {
            add_new_fish($old_fish, $anim);
        }
        else {
            add_old_fish($old_fish, $anim);
        }
    }
    else {
        add_old_fish($old_fish, $anim);
    }
}

=head2 add_new_fish($anim)

Adds a new-style fish with more detailed ASCII art.

=cut

sub add_new_fish {
    my ($anim) = @_;
    
    my @fish_art = @Asciiquarium::AsciiArt::NEW_FISH_ART;
    _add_fish_entity($anim, @fish_art);
}

=head2 add_old_fish($anim)

Adds an old-style fish with simpler ASCII art.

=cut

sub add_old_fish {
    my ($anim) = @_;
    
    my @fish_art = @Asciiquarium::AsciiArt::OLD_FISH_ART;
    _add_fish_entity($anim, @fish_art);
}

=head2 _add_fish_entity($anim, @fish_image)

Internal helper function to create a fish entity from ASCII art data.

=cut

sub _add_fish_entity {
    my ($anim, @fish_image) = @_;
    
    # Use configuration values instead of hardcoded numbers
    my $fish_colors = Asciiquarium::Config::get_color_scheme('fish_colors');
    my $fish_num = int(rand($#fish_image / 2));
    my $fish_index = $fish_num * 2;
    
    my $speed = rand(Asciiquarium::Config::get_animation_setting('fish_speed_range')) + 
                Asciiquarium::Config::get_animation_setting('fish_speed_min');
    
    my $depth_start = Asciiquarium::Config::get_depth_value('fish_start');
    my $depth_end = Asciiquarium::Config::get_depth_value('fish_end');
    my $depth = int(rand($depth_end - $depth_start)) + $depth_start;
    
    my $color_mask = $fish_image[$fish_index + 1];
    $color_mask =~ s/4/W/gm;
    $color_mask = _rand_color($color_mask, $fish_colors);

    if ($fish_num % 2) {
        $speed *= -1;
    }
    
    my $fish_object = Term::Animation::Entity->new(
        type          => 'fish',
        shape         => $fish_image[$fish_index],
        auto_trans    => 1,
        color         => $color_mask,
        position      => [ 0, 0, $depth ],
        callback_args => [ $speed, 0, 0 ],
        die_offscreen => 1,
        death_cb      => \&main::random_object,
        default_color => Asciiquarium::Config::get_color_scheme('default_colors')->{fish},
    );

    $fish_object->callback(\&fish_callback);
    $fish_object->die_offscreen(1);
    $fish_object->death_cb(sub { 
        my ($dead_fish, $anim) = @_;
        # Call main::random_object to add a new random object
        main::random_object($dead_fish, $anim);
    });
    $anim->new_entity($fish_object);
}

=head2 fish_callback($fish, $anim)

Callback function for fish movement and behavior.

=cut

sub fish_callback {
    my ($fish, $anim) = @_;

    my @args = $fish->callback_args();
    my @position = $fish->position();
    
    # Add random bubble chance
    my $bubble_chance = Asciiquarium::Config::get_entity_limit('fish_bubble_chance');
    if (rand(1) < $bubble_chance) {
        add_bubble($fish, $anim);
    }

    return ($position[0] + $args[0], $position[1] + $args[1], $position[2] + $args[2]);
}

=head2 fish_collision($fish1, $fish2, $anim)

Handles fish collision logic.

=cut

sub fish_collision {
    my ($fish1, $fish2, $anim) = @_;
    
    my @f1_args = $fish1->callback_args();
    my @f2_args = $fish2->callback_args();
    
    # Simple collision response - reverse directions
    $f1_args[0] *= -1;
    $f2_args[0] *= -1;
    
    $fish1->callback_args(@f1_args);
    $fish2->callback_args(@f2_args);
}

=head2 add_bubble($fish, $anim)

Adds a bubble near the specified fish.

=cut

sub add_bubble {
    my ($fish, $anim) = @_;

    my $cb_args = $fish->callback_args();
    my @fish_size = $fish->size();
    my @fish_pos = $fish->position();
    my @bubble_pos = @fish_pos;

    # Position bubble based on fish direction
    if ($cb_args->[0] > 0) {
        $bubble_pos[0] += $fish_size[0];
    }

    my $bubble_object = Term::Animation::Entity->new(
        shape         => $Asciiquarium::AsciiArt::BUBBLE_ART,
        position      => \@bubble_pos,
        callback_args => [ 0, -Asciiquarium::Config::get_animation_setting('bubble_rise_speed'), 0 ],
        die_offscreen => 1,
        default_color => Asciiquarium::Config::get_color_scheme('default_colors')->{bubble},
    );

    $bubble_object->callback(\&bubble_callback);
    $anim->new_entity($bubble_object);
}

=head2 bubble_callback($bubble, $anim)

Callback function for bubble movement.

=cut

sub bubble_callback {
    my ($bubble, $anim) = @_;
    
    my @args = $bubble->callback_args();
    my @position = $bubble->position();
    
    return ($position[0] + $args[0], $position[1] + $args[1], $position[2] + $args[2]);
}

=head2 _rand_color($color_mask, $colors)

Internal helper to apply random colors to a color mask.

=cut

sub _rand_color {
    my ($color_mask, $colors) = @_;
    
    foreach my $i (1 .. 9) {
        my $color = $colors->[int(rand($#{$colors}))];
        $color_mask =~ s/$i/$color/gm;
    }
    return $color_mask;
}

1;

__END__

=head1 AUTHOR

Original Asciiquarium by Kirk Baucom
Refactored Fish module for improved maintainability

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut