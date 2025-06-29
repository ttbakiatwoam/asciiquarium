package Asciiquarium::Entity::Base;

use strict;
use warnings;
use Carp qw(croak);

=head1 NAME

Asciiquarium::Entity::Base - Base class for all Asciiquarium entities

=head1 SYNOPSIS

    package Asciiquarium::Entity::Fish;
    use base 'Asciiquarium::Entity::Base';
    
    sub new {
        my ($class, %args) = @_;
        my $self = $class->SUPER::new(%args);
        # Fish-specific initialization
        return $self;
    }

=head1 DESCRIPTION

This module provides a base class for all entities in Asciiquarium,
implementing common functionality like position management, lifecycle
callbacks, and rendering properties.

=cut

our $VERSION = '1.3';

sub new {
    my ($class, %args) = @_;
    
    my $self = {
        # Core properties
        name => $args{name} || ref($class),
        type => $args{type} || lc(ref($class) =~ s/.*:://r),
        
        # Rendering properties
        shape => $args{shape} || [],
        color => $args{color} || [],
        position => $args{position} || [0, 0, 0],
        auto_trans => $args{auto_trans} // 1,
        default_color => $args{default_color} || 'white',
        
        # Animation properties
        callback => $args{callback},
        callback_args => $args{callback_args} || [],
        
        # Lifecycle properties
        die_time => $args{die_time},
        die_offscreen => $args{die_offscreen} // 0,
        death_cb => $args{death_cb},
        physical => $args{physical} // 1,
        
        # State
        created_at => time(),
        last_update => time(),
        
        # Logger (will be injected by factory)
        logger => $args{logger},
    };
    
    bless $self, $class;
    return $self;
}

=head2 name()

Get or set the entity name.

=cut

sub name {
    my ($self, $new_name) = @_;
    $self->{name} = $new_name if defined $new_name;
    return $self->{name};
}

=head2 type()

Get or set the entity type.

=cut

sub type {
    my ($self, $new_type) = @_;
    $self->{type} = $new_type if defined $new_type;
    return $self->{type};
}

=head2 position($x, $y, $z)

Get or set the entity position.

=cut

sub position {
    my ($self, $x, $y, $z) = @_;
    
    if (defined $x) {
        $self->{position} = [
            defined $x ? $x : $self->{position}->[0],
            defined $y ? $y : $self->{position}->[1], 
            defined $z ? $z : $self->{position}->[2]
        ];
    }
    
    return @{$self->{position}};
}

=head2 shape($new_shape)

Get or set the entity shape (ASCII art).

=cut

sub shape {
    my ($self, $new_shape) = @_;
    $self->{shape} = $new_shape if defined $new_shape;
    return $self->{shape};
}

=head2 color($new_color)

Get or set the entity color mask.

=cut

sub color {
    my ($self, $new_color) = @_;
    $self->{color} = $new_color if defined $new_color;
    return $self->{color};
}

=head2 callback_args($new_args)

Get or set callback arguments.

=cut

sub callback_args {
    my ($self, $new_args) = @_;
    $self->{callback_args} = $new_args if defined $new_args;
    return $self->{callback_args};
}

=head2 physical($is_physical)

Get or set whether the entity has physical collision.

=cut

sub physical {
    my ($self, $is_physical) = @_;
    $self->{physical} = $is_physical if defined $is_physical;
    return $self->{physical};
}

=head2 age()

Get the age of the entity in seconds.

=cut

sub age {
    my ($self) = @_;
    return time() - $self->{created_at};
}

=head2 should_die()

Check if the entity should die based on die_time or other conditions.

=cut

sub should_die {
    my ($self) = @_;
    
    return 0 unless $self->{die_time};
    return time() >= $self->{die_time};
}

=head2 is_offscreen($anim)

Check if the entity is offscreen (requires animation object for dimensions).

=cut

sub is_offscreen {
    my ($self, $anim) = @_;
    
    return 0 unless $anim;
    
    my ($x, $y, $z) = $self->position();
    my ($width, $height) = ($anim->width(), $anim->height());
    
    # Calculate entity size (basic implementation)
    my $entity_width = 0;
    my $entity_height = 0;
    
    if (ref($self->{shape}) eq 'ARRAY') {
        $entity_height = scalar @{$self->{shape}};
        for my $line (@{$self->{shape}}) {
            my $line_width = length($line);
            $entity_width = $line_width if $line_width > $entity_width;
        }
    } elsif ($self->{shape}) {
        my @lines = split /\n/, $self->{shape};
        $entity_height = scalar @lines;
        for my $line (@lines) {
            my $line_width = length($line);
            $entity_width = $line_width if $line_width > $entity_width;
        }
    }
    
    return ($x + $entity_width < 0 || 
            $x > $width || 
            $y + $entity_height < 0 || 
            $y > $height);
}

=head2 update($anim)

Update the entity state. Override in subclasses for entity-specific behavior.

=cut

sub update {
    my ($self, $anim) = @_;
    
    $self->{last_update} = time();
    
    # Call movement callback if defined
    if ($self->{callback}) {
        my @new_pos = $self->{callback}->($self, $anim);
        $self->position(@new_pos) if @new_pos;
    }
    
    # Log update if logger available
    if ($self->{logger}) {
        $self->{logger}->debug("Updated entity $self->{name} at position " . 
                              join(',', $self->position()));
    }
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