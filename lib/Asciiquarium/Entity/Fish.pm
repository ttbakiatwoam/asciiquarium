package Asciiquarium::Entity::Fish;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(add_fish get_new_fish_art get_old_fish_art);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 NAME

Asciiquarium::Entity::Fish - Fish entity management for Asciiquarium

=head1 DESCRIPTION

This module provides fish entity creation and management, consolidating
the previously separate add_new_fish and add_old_fish functions.

=head1 FUNCTIONS

=head2 add_fish($old_fish, $anim, $use_new_fish)

Unified fish creation function that handles both new and old fish types.

=cut

sub add_fish {
    my ($old_fish, $anim, $use_new_fish) = @_;
    
    if ($use_new_fish) {
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

=head2 add_new_fish($old_fish, $anim)

Create a new-style fish entity.

=cut

sub add_new_fish {
    my ($old_fish, $anim) = @_;
    my @fish_image = @{get_new_fish_art()};
    add_fish_entity($anim, @fish_image);
}

=head2 add_old_fish($old_fish, $anim)

Create an old-style fish entity.

=cut

sub add_old_fish {
    my ($old_fish, $anim) = @_;
    my @fish_image = @{get_old_fish_art()};
    add_fish_entity($anim, @fish_image);
}

=head2 get_new_fish_art()

Returns array reference of new fish art patterns and color masks.

=cut

sub get_new_fish_art {
    return [
        q{
   \\
  / \\
>=_('>
  \\_/
   /
},
        q{
   1
  1 1
663745
  111
   1
},
        q{
     /
    / \\
   <')_=<
    \\_/
     \\
},
        q{
     1
    1 1
   547366
    111
     1
},
        q{
  2
 1 1
547166
 111
  3
},
        q{
  ,\\
>=('>
  '/
},
        q{
  12
66745
  13
},
        q{
 /,
<')=<
 \\`
},
        q{
 21
54766
 31
},
        q{
  __
\\/ o\\
/\\__/
},
        q{
  11
61 41
61111
},
        q{
 __
/o \\/
\\__/\\
},
        q{
 11
14 16
11116
},
    ];
}

=head2 get_old_fish_art()

Returns array reference of old fish art patterns and color masks.

=cut

sub get_old_fish_art {
    return [
        q{
       .'`/
      /  (
  .-'` ` `'-._·····.')
_/ (o)        '.··.' /
)       )))     ><  <
`\\  |_\\      _.'··'. \\
  '-._  _ .-'·······'.)
      `\\__\\
},
        q{
       1111
      1  1
  1111 1 11111      111
11 141        11  11 1
5       777     11  1
11  333      111  11 1
  1111  1 111       111
      11111
},
        q{
       ,--,_
__··_\\.---'-.
\\ '.-"     // o\\
/_.'-._    \\\\  /
       `"--(/"`
},
        q{
       11111
11  111 11111
1 1111     11 141
111 1111    11 1
       11111111
},
        q{
            )\\
     __..--'' `'--.._
_.--'              `-._
>))';               ,--'
`-.._               |
     ``--...___...-'
},
        q{
            51
     111111 111111
11111              111
8556               1111
1111               5
     111111111111
},
        q{
         _(
    _..-'  `'--..__
  ._-'              '--._
'--,               ;'((< 
   |               _...-'
   '--...__...--''
},
        q{
         15
    111111  1111111
  111              11111
1111               6558
   5               1111
   111111111111111
},
        q{
      |\\   /|
      | \\_/ |
     / (o)(o) \\
    /     <>    \\
   (      <>     )
    \\     <>    /
     \\   ___   /
      | \\_/ |
      |/   \\|
},
        q{
      11   11
      1 111 1
     1 141141 1
    1     11    1
   1      11     1
    1     11    1
     1   111   1
      1 111 1
      11   11
},
        q{
           /|
       .--' |
    _./     |
 .-';   (   |
<    \\   )  |\\
 '-.'   )   | )
    |  )  .' |/
    |./|.'   |
},
        q{
           11
       111 1
    111     1
 1111   1   1
1    1   5  11
 111   5   1 5
    1  5  11 11
    11115111 1
},
        q{
 |\\
 | `-.
 |    |_
 |     '>
 |   _.'^
 | .-'
 |/
},
        q{
 11
 1 111
 1    11
 1     18
 1   1111
 1 111
 11
},
    ];
}

=head2 add_fish_entity($anim, @fish_image)

Internal function to create a fish entity from image data.
This is called by both new and old fish creation functions.

=cut

sub add_fish_entity {
    my $anim = shift;
    my @fish_image = @_;

    # Fish entity creation logic (to be refactored from main script)
    # This will be moved from the main script in a future iteration
    die "add_fish_entity: Implementation needs to be extracted from main script";
}

1;

__END__

=head1 AUTHOR

Original fish art by Joan Stark and others.
Module structure by refactoring team.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut