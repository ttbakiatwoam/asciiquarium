package Asciiquarium::Logger;

use strict;
use warnings;
use Carp qw(croak);

=head1 NAME

Asciiquarium::Logger - Logging system for Asciiquarium

=head1 SYNOPSIS

    use Asciiquarium::Logger;
    
    my $logger = Asciiquarium::Logger->new(
        level => 'DEBUG',
        file => 'asciiquarium.log'
    );
    
    $logger->debug("Debug message");
    $logger->info("Info message");
    $logger->warn("Warning message");
    $logger->error("Error message");

=head1 DESCRIPTION

This module provides a comprehensive logging system for Asciiquarium,
replacing the simple dprint() function with proper log levels and formatting.

=cut

our $VERSION = '1.3';

# Log levels (lower number = higher priority)
my %LOG_LEVELS = (
    ERROR => 0,
    WARN  => 1,
    INFO  => 2,
    DEBUG => 3,
);

sub new {
    my ($class, %args) = @_;
    
    my $self = {
        level => $args{level} || 'INFO',
        file => $args{file} || undef,
        handle => $args{handle} || undef,
        enabled => $args{enabled} // 1,
    };
    
    bless $self, $class;
    
    # Validate log level
    unless (exists $LOG_LEVELS{uc($self->{level})}) {
        croak "Invalid log level: $self->{level}. Valid levels: " . 
              join(', ', sort keys %LOG_LEVELS);
    }
    
    $self->{level} = uc($self->{level});
    
    # Open log file if specified
    if ($self->{file} && !$self->{handle}) {
        $self->_open_log_file();
    }
    
    return $self;
}

sub _open_log_file {
    my ($self) = @_;
    
    open my $fh, '>>', $self->{file} 
        or croak "Cannot open log file $self->{file}: $!";
    
    $self->{handle} = $fh;
}

sub _should_log {
    my ($self, $level) = @_;
    return 0 unless $self->{enabled};
    return $LOG_LEVELS{uc($level)} <= $LOG_LEVELS{$self->{level}};
}

sub _log {
    my ($self, $level, @messages) = @_;
    
    return unless $self->_should_log($level);
    
    my $timestamp = scalar localtime;
    my $message = join(' ', @messages);
    my $log_line = "[$timestamp] [$level] $message\n";
    
    if ($self->{handle}) {
        print {$self->{handle}} $log_line;
        $self->{handle}->flush();
    } elsif ($self->{file}) {
        # Reopen file handle if it was closed
        $self->_open_log_file();
        print {$self->{handle}} $log_line;
        $self->{handle}->flush();
    } else {
        # Log to STDERR if no file specified
        print STDERR $log_line;
    }
}

=head2 debug(@messages)

Log debug message.

=cut

sub debug {
    my ($self, @messages) = @_;
    $self->_log('DEBUG', @messages);
}

=head2 info(@messages)

Log info message.

=cut

sub info {
    my ($self, @messages) = @_;
    $self->_log('INFO', @messages);
}

=head2 warn(@messages)

Log warning message.

=cut

sub warn {
    my ($self, @messages) = @_;
    $self->_log('WARN', @messages);
}

=head2 error(@messages)

Log error message.

=cut

sub error {
    my ($self, @messages) = @_;
    $self->_log('ERROR', @messages);
}

=head2 set_level($level)

Change the logging level.

=cut

sub set_level {
    my ($self, $level) = @_;
    
    $level = uc($level);
    unless (exists $LOG_LEVELS{$level}) {
        croak "Invalid log level: $level. Valid levels: " . 
              join(', ', sort keys %LOG_LEVELS);
    }
    
    $self->{level} = $level;
}

=head2 enable()

Enable logging.

=cut

sub enable {
    my ($self) = @_;
    $self->{enabled} = 1;
}

=head2 disable()

Disable logging.

=cut

sub disable {
    my ($self) = @_;
    $self->{enabled} = 0;
}

=head2 DESTROY()

Close file handle when object is destroyed.

=cut

sub DESTROY {
    my ($self) = @_;
    close $self->{handle} if $self->{handle};
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