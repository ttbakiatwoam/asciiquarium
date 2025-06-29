package Asciiquarium::Entity::Seaweed;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(add_seaweed add_all_seaweed);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 NAME

Asciiquarium::Entity::Seaweed - Seaweed entity management for Asciiquarium

=head1 DESCRIPTION

This module provides seaweed entity creation and management, including
dynamic generation of seaweed sprites.

=head1 FUNCTIONS

=head2 add_all_seaweed($anim, $depth_config, $animation_config)

Adds multiple seaweed entities based on screen width.

=cut

sub add_all_seaweed {
    my ($anim, $depth_config, $animation_config) = @_;
    
    # Use configuration if provided, otherwise use defaults
    $animation_config ||= { seaweed_density => 15 };
    
    # Calculate seaweed count based on screen width
    my $seaweed_count = int($anim->width() / $animation_config->{seaweed_density});
    
    for (1 .. $seaweed_count) {
        add_seaweed(undef, $anim, $depth_config, $animation_config);
    }
}

=head2 add_seaweed($old_seaweed, $anim, $depth_config, $animation_config)

Creates a single seaweed entity with random height and position.

=cut

sub add_seaweed {
    my ($old_seaweed, $anim, $depth_config, $animation_config) = @_;
    
    # Use configuration defaults if not provided
    $animation_config ||= {
        seaweed_min_height => 3,
        seaweed_max_height => 7,
        seaweed_min_speed => 0.25,
        seaweed_max_speed => 0.30,
        seaweed_min_lifespan => 480,
        seaweed_max_lifespan => 720,
    };
    
    # Generate seaweed image dynamically
    my @seaweed_image = ('', '');
    my $height_range = $animation_config->{seaweed_max_height} - $animation_config->{seaweed_min_height};
    my $height = int(rand($height_range)) + $animation_config->{seaweed_min_height};
    
    for my $i (1 .. $height) {
        my $left_side = $i % 2;
        my $right_side = !$left_side;
        $seaweed_image[$left_side] .= "(\n";
        $seaweed_image[$right_side] .= " )\n";
    }
    
    # Random position
    my $x = int(rand($anim->width() - 2)) + 1;
    my $y = $anim->height() - $height;
    
    # Animation speed
    my $speed_range = $animation_config->{seaweed_max_speed} - $animation_config->{seaweed_min_speed};
    my $anim_speed = rand($speed_range) + $animation_config->{seaweed_min_speed};
    
    # Lifespan calculation
    my $lifespan_range = $animation_config->{seaweed_max_lifespan} - $animation_config->{seaweed_min_lifespan};
    my $lifespan = int(rand($lifespan_range)) + $animation_config->{seaweed_min_lifespan};
    
    # Create seaweed entity
    $anim->new_entity(
        name          => 'seaweed' . rand(1),
        shape         => \@seaweed_image,
        position      => [ $x, $y, $depth_config->{'seaweed'} ],
        callback_args => [ 0, 0, 0, $anim_speed ],
        die_time      => time() + $lifespan,
        death_cb      => sub { add_seaweed(@_) },
        default_color => 'green',
    );
}

1;

__END__

=head1 AUTHOR

Original seaweed logic by Kirk Baucom and contributors.
Module structure by refactoring team.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut