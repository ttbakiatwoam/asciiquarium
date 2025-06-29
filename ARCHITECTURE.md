# Asciiquarium - Modular Architecture

This is a refactored version of Asciiquarium that addresses technical debt and introduces a modular architecture while maintaining full backward compatibility.

## New Architecture

### Core Modules

- **`lib/Asciiquarium/Config.pm`** - Configuration and ASCII art management
- **`lib/Asciiquarium/Logger.pm`** - Comprehensive logging system with multiple levels
- **`lib/Asciiquarium/EntityFactory.pm`** - Entity creation factory to eliminate code duplication
- **`lib/Asciiquarium/Entity/Base.pm`** - Base class for all entities with lifecycle management

### Configuration Files

- **`data/config.json`** - Configurable values (depths, colors, timing, gameplay settings)
- **`data/ascii_art.json`** - ASCII art patterns and sprites extracted from hardcoded strings

## Improvements Made

### ✅ Completed

1. **Modular Structure**: Separated logic, configuration, and data into distinct modules
2. **External Configuration**: Moved hardcoded ASCII art and magic numbers to JSON files
3. **Code Deduplication**: EntityFactory eliminates redundant old/new fish creation functions
4. **Modern Logging**: Replaced simple `dprint()` with proper logging levels and formatting
5. **Documentation**: Added comprehensive POD documentation to all modules
6. **Error Handling**: Enhanced signal handling and graceful error management
7. **Backward Compatibility**: Falls back to original behavior if modules can't be loaded

### 🔄 In Progress

8. **Entity Management**: Base entity class with proper lifecycle methods
9. **Performance Optimization**: Improved rendering and entity lifecycle management

### 📋 Planned

10. **Specialized Entity Classes**: Fish, Shark, Seaweed, etc. as separate classes
11. **Test Suite**: Comprehensive tests for all modules
12. **Configuration Validation**: Runtime validation of config files

## Usage

The script works exactly as before - all changes are internal:

```bash
./asciiquarium            # Normal mode with new architecture
./asciiquarium --classic  # Classic mode (old fish/monster patterns)
./asciiquarium --help     # Show options
```

## Testing

Test the modular components independently:

```bash
perl test_modules.pl
```

## Configuration

Edit `data/config.json` to modify:
- Entity depths and layer ordering
- Color palettes  
- Animation speeds and timing
- Gameplay parameters

Edit `data/ascii_art.json` to modify:
- ASCII art patterns for all entities
- Animation frames
- Visual appearance

## Development

All modules include comprehensive POD documentation:

```bash
perldoc lib/Asciiquarium/Config.pm
perldoc lib/Asciiquarium/Logger.pm
perldoc lib/Asciiquarium/EntityFactory.pm
```

The modular design makes it easy to:
- Add new entity types
- Modify existing behaviors
- Create custom themes
- Add new features without touching the main script

## Backward Compatibility

If the `lib/` or `data/` directories are missing or corrupted, the script automatically falls back to the original hardcoded behavior with a warning message.