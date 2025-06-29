#!/usr/bin/env perl

# Simple test script to validate the modular components

use strict;
use warnings;
use FindBin qw($RealBin);
use lib "$RealBin/lib";

print "Testing Asciiquarium modular components...\n";

# Test Config module
eval {
    require Asciiquarium::Config;
    my $config = Asciiquarium::Config->new();
    print "✓ Config module loaded successfully\n";
    
    my $depths = $config->get_depths();
    print "✓ Depth configuration loaded: " . (scalar keys %$depths) . " entries\n";
    
    my $colors = [$config->get_colors()];
    print "✓ Color configuration loaded: " . (scalar @$colors) . " colors\n";
    
    my $water_art = $config->get_ascii_art('water_segments');
    print "✓ ASCII art loaded: " . (scalar @$water_art) . " water segments\n";
};
if ($@) {
    print "✗ Config module error: $@\n";
}

# Test Logger module
eval {
    require Asciiquarium::Logger;
    my $logger = Asciiquarium::Logger->new(level => 'DEBUG');
    print "✓ Logger module loaded successfully\n";
    
    $logger->debug("Debug test message");
    $logger->info("Info test message");
    print "✓ Logger functioning correctly\n";
};
if ($@) {
    print "✗ Logger module error: $@\n";
}

# Test EntityFactory module
eval {
    require Asciiquarium::EntityFactory;
    require Asciiquarium::Config;
    require Asciiquarium::Logger;
    
    my $config = Asciiquarium::Config->new();
    my $logger = Asciiquarium::Logger->new(level => 'INFO');
    my $factory = Asciiquarium::EntityFactory->new(
        config => $config,
        logger => $logger
    );
    print "✓ EntityFactory module loaded successfully\n";
};
if ($@) {
    print "✗ EntityFactory module error: $@\n";
}

print "\nModule testing complete!\n";