package Asciiquarium::AsciiArt;

=head1 NAME

Asciiquarium::AsciiArt - ASCII art data for Asciiquarium

=head1 DESCRIPTION

This module contains all ASCII art definitions for various entities
in the aquarium, extracted from the main script for better organization
and maintainability.

=cut

use strict;
use warnings;

our $VERSION = '1.3';

=head1 ASCII ART DATA

=head2 CASTLE_ART

Castle ASCII art and color masks.

=cut

our @CASTLE_ART = (
    q{
                gg
              XXXX
             X    X
            X      X
           X        X

                rr
              rrrrrr
             r   r  r
            r  r    r
           r     r   r
           r  r   r  r
          rrrrrrrrrrrr
          r r  r  r  r
         rrrrrrrrrrrrr
         r rrr  rr  rr
        |_=__-_ =_|_[ ]_[ ]_|_=-___-__|
        | _- =  | =_ = _    |= _=   |
        |= -[]  |- = _ =    |_-=_[] |
        | =_    |= - ___    | =_ =  |
        |=  []- |-  /| |\   |=_ =[] |
        |- =_   | =|_|_|_|  |- = -  |
        |_______|__|     |__|_______|
},
    q{
                gg
              XXXX
             X    X
            X      X
           X        X

                rr
              rrrrrr
             r   r  r
            r  r    r
           r     r   r
           r  r   r  r
          rrrrrrrrrrrr
          r r  r  r  r
         rrrrrrrrrrrrr
         r rrr  rr  rr
        |_=__-_ =_|_[ ]_[ ]_|_=-___-__|
        | _- =  | =_ = _    |= _=   |
        |= -[]  |- = _ =    |_-=_[] |
        | =_    |= - ___    | =_ =  |
        |=  []- |-  /|*|\   |=_ =[] |
        |- =_   | =|_|_|_|  |- = -  |
        |_______|__|     |__|_______|
},
    q{
                gg
              XXXX
             X    X
            X      X
           X        X

                rr
              rrrrrr
             r   r  r
            r  r    r
           r     r   r
           r  r   r  r
          rrrrrrrrrrrr
          r r  r  r  r
         rrrrrrrrrrrrr
         r rrr  rr  rr
        |_=__-_ =_|_[ ]_[ ]_|_=-___-__|
        | _- =  | =_ = _    |= _=   |
        |= -[]  |- = _ =    |_-=_[] |
        | =_    |= - ___    | =_ =  |
        |=  []- |-  /||||\   |=_ =[] |
        |- =_   | =|_|_|_|  |- = -  |
        |_______|__|     |__|_______|
}
);

our @CASTLE_MASK = (
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
             yy yy
            yyyyyyy
            y     y
}
);

=head2 FISH_ART

Fish ASCII art for different types and directions.

=cut

our @NEW_FISH_ART = (
    q{
       \
     ...\..,
\  /'       \
 >=     (  ' >
/  \      / /
    `'::''/'
        `
},
    q{
       1
     111011
1  71       8
 44     2  5 4
1  8      1 1
    511335
        5
},
    q{
      /
  ,../...
 /       '\ /
< '  )     =<
 \ \      /  \
  `\'::''`
     `
},
    q{
      1
  0111111
 1       58 1
4 5  2     44
 8 8      1  8
  858335
     5
},
    q{
     \
   ..\..,
 /'     \
>=   (  '>
 \     /
  `'::''
     `
},
    q{
     1
   111011
 75     8
44   2  54
 8     1
  511335
     5
},
    q{
    /
  ,../..
 /     '\
<'  )   =<
 \     /
  `'::''
     `
},
    q{
    1
  0111101
 1     58
45  2   44
 8     1
  511335
     5
},
    q{
  2
 1 1
547166
 111
  3
},
    q{
  ,\
>=('\>
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
 \`
},
    q{
 21
54766
 31
},
    q{
  __
\/ o\
/\__/
},
    q{
  11
61 41
61111
},
    q{
 __
/o \/
\__/\
},
    q{
 11
14 16
11116
}
);

our @OLD_FISH_ART = (
    q{
     \:.
     |  \
   /'    )
>=('   ' >
   \    (
     |  /
     /:`
},
    q{
     810
     4  8
   75    2
448   5 4
   8    2
     4  1
     185
},
    q{
    .:\ 
   /  |
  (    '\
 < '   ')=<
  )    /
   \  |
    `:\
},
    q{
    018
   1  4
  2    58
 4 5   844
  2    1
   8  4
    581
},
    q{
       \
     ..\.
   /'   )
>=('   '>
   \   (
     `/.'
       
},
    q{
       8
     1181
   75   2
448   54
   8   2
     181
       
},
    q{
      /
    ./../
   (   '\
  <'   ')=<
   )   /
   `.\'
       
},
    q{
      1
    1811
   2   58
  45   844
   2   1
   881
       
},
    q{
     \
   ../
  (  )
>=(' >
  (  )
   \.'
     
},
    q{
     8
   118
  2  2
442 4
  2  2
   88
     
},
    q{
    /
   \..,
   )  (
  < ')=<
   )  (
   `./ 
      
},
    q{
    1
   8111
   2  2
  4 244
   2  2
   81 
      
}
);

=head2 SEAWEED_ART

Seaweed ASCII art.

=cut

our @SEAWEED_ART = ('', '');

=head2 BUBBLE_ART

Bubble ASCII art.

=cut

our $BUBBLE_ART = q{
o
};

=head2 ENVIRONMENT_ART

Water surface and environment ASCII art.

=cut

our @WATER_LINES = (
    q{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~},
    q{^^^^ ^ ^^^ ^ ^^^^^ ^^ ^^ ^^^ ^ ^^^ ^^^^^ ^ ^^^ ^^ ^^^^^ ^ ^^^ ^^ ^ ^^^^^^^^^^^},
    q{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~},
    q{^^^^^ ^^ ^ ^^^^^ ^ ^^^ ^^ ^^ ^ ^^ ^^ ^^^^^ ^^^^^ ^ ^^^ ^^ ^^^ ^^^^ ^^^ ^ ^^^^^^^^}
);

our @WATER_GAPS = (
    q{                                                                                },
    q{                                                                               },
    q{                                                                                },
    q{                                                                               }
);

1;

__END__

=head1 AUTHOR

Original Asciiquarium by Kirk Baucom
Refactored ASCII art module for improved maintainability

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut