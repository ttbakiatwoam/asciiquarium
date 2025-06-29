package Asciiquarium::EntityFactory;

use strict;
use warnings;
use Carp qw(croak);
use Asciiquarium::Entity::Base;

=head1 NAME

Asciiquarium::EntityFactory - Factory for creating Asciiquarium entities

=head1 SYNOPSIS

    use Asciiquarium::EntityFactory;
    
    my $factory = Asciiquarium::EntityFactory->new(
        config => $config,
        logger => $logger
    );
    
    my $fish = $factory->create_fish($anim);
    my $shark = $factory->create_shark($anim);

=head1 DESCRIPTION

This module provides a factory for creating entities, eliminating code
duplication between old and new entity creation functions and centralizing
entity management.

=cut

our $VERSION = '1.3';

sub new {
    my ($class, %args) = @_;
    
    my $self = {
        config => $args{config} || croak("Config object required"),
        logger => $args{logger},
        new_fish => $args{new_fish} // 1,
        new_monster => $args{new_monster} // 1,
    };
    
    bless $self, $class;
    return $self;
}

=head2 create_fish($anim, %override_args)

Create a fish entity using either new or old fish patterns.

=cut

sub create_fish {
    my ($self, $anim, %override_args) = @_;
    
    if ($self->{new_fish}) {
        return $self->_create_new_fish($anim, %override_args);
    } else {
        return $self->_create_old_fish($anim, %override_args);
    }
}

sub _create_new_fish {
    my ($self, $anim, %override_args) = @_;
    
    # New fish patterns (simplified extraction from original)
    my @fish_patterns = (
        {
            shape => [
                "  2\n 1 1\n547166\n 111\n  3",
                "  ,\\\n>=('>\n  '/"
            ],
            mask => [
                "  2\n 1 1\n547166\n 111\n  3",
                "  12\n66745\n  13"
            ]
        },
        {
            shape => [
                " /,\n<')=<\n \\`",
                " 21\n54766\n 31"
            ],
            mask => [
                "  __\n\\/ o\\\n/\\__/",
                "  11\n61 41\n61111"
            ]
        }
        # Add more patterns as needed
    );
    
    return $self->_create_fish_from_patterns(\@fish_patterns, $anim, %override_args);
}

sub _create_old_fish {
    my ($self, $anim, %override_args) = @_;
    
    # Old fish patterns (simplified extraction from original)
    my @fish_patterns = (
        {
            shape => [
                "  __\n/o \\/\n\\__/\\",
                " 11\n14 16\n11116"
            ],
            mask => [
                "  __\n\\/ o\\\n/\\__/",
                " __\n/o \\/\n\\__/\\"
            ]
        }
        # Add more old patterns as needed
    );
    
    return $self->_create_fish_from_patterns(\@fish_patterns, $anim, %override_args);
}

sub _create_fish_from_patterns {
    my ($self, $patterns, $anim, %override_args) = @_;
    
    my $fish_num = int(rand(scalar @$patterns));
    my $pattern = $patterns->[$fish_num];
    
    my $speed = rand(2) + $self->{config}->get_config('fish', 'min_speed');
    my $depth = int(rand(
        $self->{config}->get_depth('fish_end') - 
        $self->{config}->get_depth('fish_start')
    )) + $self->{config}->get_depth('fish_start');
    
    # Determine direction
    if ($fish_num % 2) {
        $speed *= -1;
    }
    
    my $color_mask = $pattern->{mask}->[0];
    $color_mask =~ s/4/W/gm;
    $color_mask = $self->_randomize_color($color_mask);
    
    my $entity = Asciiquarium::Entity::Base->new(
        type => 'fish',
        shape => $pattern->{shape}->[0],
        auto_trans => 1,
        color => $color_mask,
        position => [0, 0, $depth],
        callback_args => [$speed, 0, 0, $self->{config}->get_config('fish', 'bubble_probability')],
        callback => \&_fish_callback,
        die_offscreen => 1,
        death_cb => \&_fish_death_callback,
        default_color => 'yellow',
        logger => $self->{logger},
        %override_args
    );
    
    $self->{logger}->debug("Created fish entity with speed $speed at depth $depth") 
        if $self->{logger};
    
    return $entity;
}

=head2 create_shark($anim, %override_args)

Create a shark entity.

=cut

sub create_shark {
    my ($self, $anim, %override_args) = @_;
    
    # Simplified shark shape (extract full shape from original)
    my $shark_shape = <<"EOF";
                             __
                           /   \\
                          | o o |
EOF
    
    my $dir = int(rand(2));
    my $x = $dir ? $anim->width() - 2 : -30;
    my $speed = $dir ? -4 : 4;
    
    my $entity = Asciiquarium::Entity::Base->new(
        type => 'shark',
        shape => $shark_shape,
        auto_trans => 1,
        position => [$x, int(rand($anim->height() - 10)), $self->{config}->get_depth('shark')],
        callback_args => [$speed, 0, 0],
        die_offscreen => 1,
        death_cb => \&_shark_death_callback,
        default_color => 'CYAN',
        logger => $self->{logger},
        %override_args
    );
    
    $self->{logger}->info("Created shark entity moving " . ($dir ? "left" : "right")) 
        if $self->{logger};
    
    return $entity;
}

=head2 create_seaweed($anim, %override_args)

Create a seaweed entity.

=cut

sub create_seaweed {
    my ($self, $anim, %override_args) = @_;
    
    my $seaweed_art = $self->{config}->get_ascii_art('seaweed');
    my $seaweed_shape = $seaweed_art->[int(rand(scalar @$seaweed_art))];
    
    my $x = int(rand($anim->width() - 5));
    my $y = $anim->height() - 12;
    my $lifetime = int(rand(4 * 60)) + (8 * 60); # 8-12 minutes
    
    my $entity = Asciiquarium::Entity::Base->new(
        name => 'seaweed' . rand(1),
        type => 'seaweed',
        shape => $seaweed_shape,
        position => [$x, $y, $self->{config}->get_depth('seaweed')],
        callback_args => [0, 0, 0, $self->{config}->get_config('seaweed', 'animation_speed')],
        die_time => time() + $lifetime,
        death_cb => \&_seaweed_death_callback,
        default_color => 'green',
        logger => $self->{logger},
        %override_args
    );
    
    $self->{logger}->debug("Created seaweed entity at ($x, $y) with ${lifetime}s lifetime") 
        if $self->{logger};
    
    return $entity;
}

sub _randomize_color {
    my ($self, $color_mask) = @_;
    
    my @colors = $self->{config}->get_colors();
    foreach my $i (1 .. 9) {
        my $color = $colors[int(rand($#colors))];
        $color_mask =~ s/$i/$color/gm;
    }
    
    return $color_mask;
}

# Callback functions (simplified - in full implementation these would be more complex)
sub _fish_callback {
    my ($entity, $anim) = @_;
    # Implement fish movement logic
    return; # Return new position if needed
}

sub _fish_death_callback {
    my ($entity, $anim) = @_;
    # Handle fish death
}

sub _shark_death_callback {
    my ($entity, $anim) = @_;
    # Handle shark death
}

sub _seaweed_death_callback {
    my ($entity, $anim) = @_;
    # Handle seaweed death - create new seaweed
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