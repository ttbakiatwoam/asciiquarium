package Asciiquarium::Logger;

=head1 NAME

Asciiquarium::Logger - Simple logging facility for Asciiquarium

=head1 DESCRIPTION

This module provides basic logging and debugging functionality for the
Asciiquarium application.

=cut

use strict;
use warnings;

our $VERSION = '1.3';

# Log levels
our %LOG_LEVELS = (
    DEBUG => 0,
    INFO  => 1,
    WARN  => 2,
    ERROR => 3,
);

our $LOG_LEVEL = $LOG_LEVELS{INFO};  # Default log level
our $LOG_FILE = 'asciiquarium.log';

=head1 SUBROUTINES

=head2 set_log_level($level)

Sets the logging level.

=cut

sub set_log_level {
    my ($level) = @_;
    $LOG_LEVEL = $LOG_LEVELS{uc($level)} // $LOG_LEVELS{INFO};
}

=head2 set_log_file($filename)

Sets the log file name.

=cut

sub set_log_file {
    my ($filename) = @_;
    $LOG_FILE = $filename;
}

=head2 log_message($level, $message)

Logs a message with the specified level.

=cut

sub log_message {
    my ($level, $message) = @_;
    
    my $level_num = $LOG_LEVELS{uc($level)} // $LOG_LEVELS{INFO};
    return if $level_num < $LOG_LEVEL;
    
    my $timestamp = scalar localtime;
    my $formatted_message = sprintf("[%s] %s: %s\n", $timestamp, uc($level), $message);
    
    if (open(my $fh, '>>', $LOG_FILE)) {
        print $fh $formatted_message;
        close($fh);
    }
}

=head2 debug($message)

Logs a debug message.

=cut

sub debug {
    my ($message) = @_;
    log_message('DEBUG', $message);
}

=head2 info($message)

Logs an info message.

=cut

sub info {
    my ($message) = @_;
    log_message('INFO', $message);
}

=head2 warn($message)

Logs a warning message.

=cut

sub warn {
    my ($message) = @_;
    log_message('WARN', $message);
}

=head2 error($message)

Logs an error message.

=cut

sub error {
    my ($message) = @_;
    log_message('ERROR', $message);
}

1;

__END__

=head1 AUTHOR

Asciiquarium logging module for improved maintainability

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=cut