# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-06-30

### Enhanced
- Redesigned example app
- Improved vehicle showcase with better visual hierarchy

## [1.0.0] - 2025-06-30

### Added
- Initial release of Tuesdae Assets - animated vehicle widgets for Flutter
- Six vehicle types with unique visual characteristics:
  - **Regular Car**: Standard passenger vehicle
  - **Ambulance**: Emergency vehicle with medical cross and flashing lights
  - **Police Car**: Law enforcement vehicle with badge and flashing lights
  - **Tractor**: Agricultural vehicle with treads and exhaust smoke effects
  - **School Bus**: Safety vehicle with stop sign and warning lights
  - **Impatient Car**: Regular car with attitude for game scenarios
- Four directional orientations (North, South, East, West)
- Comprehensive vehicle configuration system:
  - Customizable primary colors
  - Adjustable vehicle sizes
  - Directional control
  - Emergency light flashing
  - Crash state visualization
  - Special effects toggle
  - Animation speed control
- Preset vehicle configurations for common use cases:
  - Standard Car
  - Emergency Ambulance
  - Active Police
  - Farm Tractor
  - Safety Bus
  - Crashed Car
- Custom vehicle painter for high-quality rendering
- Vehicle widget with animation support
- Comprehensive documentation and examples
- Flutter 3.0+ compatibility
- Dart 3.0+ compatibility

### Features
- **Realistic Animations**: Smooth, predictable animations for all vehicle types
- **Emergency Effects**: Flashing lights for ambulances and police cars
- **Special Effects**: Exhaust smoke, stop signs, and other vehicle-specific details
- **Crash Visualization**: Visual indicators for damaged/crashed vehicles
- **Customizable Appearance**: Full control over colors, sizes, and orientations
- **Performance Optimized**: Efficient custom painting for smooth animations
- **Developer Friendly**: Clean API with preset configurations for quick setup

### Technical
- Built with Flutter's custom painting system for optimal performance
- Enum-based vehicle type and direction system for type safety
- Immutable configuration objects with copyWith functionality
- Comprehensive test coverage ready
- Follows Flutter package development best practices
- Compatible with Flutter web, mobile, and desktop platforms

### Documentation
- Complete API documentation
- Usage examples and tutorials
- Vehicle type reference guide
- Configuration options guide
- Animation and effects documentation
