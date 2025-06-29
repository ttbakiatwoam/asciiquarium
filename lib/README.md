# Asciiquarium Library Modules

This directory contains the refactored modular components of Asciiquarium.

## Modules

### Asciiquarium::Config
Centralizes all configuration values, constants, and settings that were previously hardcoded throughout the application.

### Asciiquarium::AsciiArt  
Contains ASCII art definitions for various entities in the aquarium (fish, castle, seaweed, etc.).

### Asciiquarium::Environment
Handles environment setup including water surface, seaweed, and castle elements.

### Asciiquarium::Fish
Manages fish creation, movement, and behavior, consolidating the old and new fish functionality.

### Asciiquarium::Logger
Provides basic logging and debugging functionality.

## Benefits

- **Modular Structure**: Code is organized into logical, focused modules
- **Centralized Configuration**: All magic numbers and settings are in one place
- **Maintainability**: Easier to update and extend functionality
- **Documentation**: Each module includes comprehensive POD documentation
- **Logging**: Built-in debugging and monitoring capabilities

## Usage

The main `asciiquarium` script automatically loads these modules. The modular structure maintains backward compatibility while improving code organization.