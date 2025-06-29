package Asciiquarium::Logger;

use strict;
use warnings;
use Exporter qw(import);

our @EXPORT_OK = qw(debug_log);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 NAME

Asciiquarium::Logger - Simple logging functionality for Asciiquarium

=head1 DESCRIPTION

This module provides basic logging functionality to replace the simple
debug print function in the original code.

=head1 FUNCTIONS

=head2 debug_log(@messages)

Writes debug messages to a debug file. This replaces the original dprint function
with a more structured approach.

=cut

our $DEBUG_FILE = 'debug.log';
our $DEBUG_ENABLED = $ENV{ASCIIQUARIUM_DEBUG} || 0;

sub debug_log {
    return unless $DEBUG_ENABLED;
    
    my @messages = @_;
    
    if (open(my $fh, '>>', $DEBUG_FILE)) {
        my $timestamp = scalar localtime;
        print $fh "[$timestamp] ", @messages, "\n";
        close($fh);
    }
}

1;

__END__

=head1 USAGE

Enable debug logging by setting the ASCIIQUARIUM_DEBUG environment variable:

    export ASCIIQUARIUM_DEBUG=1
    ./asciiquarium

Debug messages will be written to debug.log in the current directory.

=head1 AUTHOR

Refactoring team.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut