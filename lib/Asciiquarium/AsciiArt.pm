package Asciiquarium::AsciiArt;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(get_castle_art get_seaweed_art);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 NAME

Asciiquarium::AsciiArt - ASCII art data for Asciiquarium entities

=head1 DESCRIPTION

This module provides ASCII art and color mask data for various entities
in the Asciiquarium, including castles, seaweed, fish, and other creatures.

=head1 FUNCTIONS

=head2 get_castle_art()

Returns an array reference containing castle image frames and color masks.

=cut

sub get_castle_art {
    my @castle_image = (
        q{
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /| |\   |=_ =[] |
 |- =_   | =| | | |  |- = -  |
 |_______|__|_|_|_|__|_______|
},
        q{
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /| |\   |=_ =[] |
 |- =_   | =|_|_|_|  |- = -  |
 |_______|__|     |__|_______|
},
        q{
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /|_|\   |=_ =[] |
 |- =_   | =|     |  |- = -  |
 |_______|__|     |__|_______|
},
        q{
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /   \   |=_ =[] |
 |- =_   | =|     |  |- = -  |
 |_______|__|     |__|_______|
},
        q{
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /|_|\   |=_ =[] |
 |- =_   | =|     |  |- = -  |
 |_______|__|     |__|_______|
},
        q{
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ \[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /| |\   |=_ =[] |
 |- =_   | =|_|_|_|  |- = -  |
 |_______|__|     |__|_______|
}
    );

    my @castle_mask = (
        q{
                GG

              rrr
             r   r
            r     r
           r       r



              yyy
             yy yy
            y y y y
            yyyyyyy
},
        q{
                GG

              rrr
             r   r
            r     r
           r       r



              yyy
             yy yy
            yyyyyyy
            y     y
},
        q{
                GG

              rrr
             r   r
            r     r
           r       r



              yyy
             yyyyy
            y     y
            y     y
},
        q{
                GG

              rrr
             r   r
            r     r
           r       r



              yyy
             y   y
            y     y
            y     y
},
        q{
                GG

              rrr
             r   r
            r     r
           r       r



              yyy
             yyyyy
            y     y
            y     y
},
        q{
                GG

              rrr
             r   r
            r     r
           r       r



              yyy
             yy yy
            yyyyyyy
            y     y
}
    );

    return {
        images => \@castle_image,
        masks  => \@castle_mask,
    };
}

=head2 get_seaweed_art()

Returns a reference to seaweed art generation template.

=cut

sub get_seaweed_art {
    # Seaweed is dynamically generated, so we return the template
    return {
        left_char  => '(',
        right_char => ')',
        max_height => 7,  # 3 + 4 from rand(4)
        min_height => 3,
    };
}

1;

__END__

=head1 AUTHOR

Original ASCII art by Joan Stark and others.
Module structure by refactoring team.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut