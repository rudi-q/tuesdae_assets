# 🚗 Tuesdae Assets

**Accessible animated vehicle widgets for Flutter**

[![pub package](https://img.shields.io/pub/v/tuesdae_assets.svg)](https://pub.dev/packages/tuesdae_assets)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Perfect for traffic games, simulations, and educational apps. Designed with accessibility in mind - providing clear visual feedback, predictable animations, and high contrast elements for better focus.

## ✨ Features

- **6 Vehicle Types**: Cars, ambulances, police, tractors, school buses, and more
- **Realistic Animations**: Flashing emergency lights, exhaust smoke, stop signs
- **Accessible Design**: High contrast, clear visuals, predictable behaviors
- **Highly Customizable**: Colors, sizes, directions, effects
- **Performance Optimized**: Smooth 60fps animations
- **Zero Dependencies**: Uses only Flutter's built-in capabilities

## 🚑 Vehicle Types

| Vehicle | Features | Use Cases |
|---------|----------|-----------|
| **Regular Car** | Standard passenger vehicle | Traffic simulations, games |
| **Ambulance** | Flashing red/blue lights, medical cross | Emergency scenarios |
| **Police Car** | Flashing lights, badge, "POLICE" text | Law enforcement games |
| **Tractor** | Treads, exhaust smoke, "SLOW" warning | Agricultural/construction sims |
| **School Bus** | Stop sign, safety lights, "SCHOOL BUS" text | Education, safety apps |
| **Impatient Car** | Same as regular but configurable attitude | Traffic behavior modeling |

## 🎮 Quick Start

```bash
flutter pub add tuesdae_assets
```
OR

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tuesdae_assets: ^1.0.1
```

### Basic Usage

```dart
import 'package:tuesdae_assets/tuesdae_assets.dart';

// Simple ambulance
TuesdaeVehicle.ambulance()

// Custom police car
TuesdaeVehicle(
  type: VehicleType.police,
  config: VehicleConfig(
    primaryColor: Colors.blue,
    size: 30.0,
    direction: VehicleDirection.east,
    isFlashing: true,
  ),
)

// Using presets
TuesdaeVehicle.preset(
  type: VehicleType.tractor,
  config: VehiclePresets.farmTractor,
)
```

### Interactive Example

```dart
TuesdaeVehicle.schoolBus(
  config: VehiclePresets.safetyBus.copyWith(
    isFlashing: true,
    direction: VehicleDirection.north,
  ),
  onTap: () => print('School bus tapped!'),
)
```

## 🎨 Customization

### Vehicle Configuration

```dart
VehicleConfig(
  primaryColor: Colors.red,        // Vehicle body color
  size: 25.0,                      // Base size (proportional scaling)
  direction: VehicleDirection.east, // Facing direction
  isFlashing: true,                // Emergency lights on/off
  isCrashed: false,                // Show crash effects
  showEffects: true,               // Enable special effects
  animationSpeed: 1.5,             // Speed multiplier for animations
)
```

### Preset Configurations

```dart
// Ready-to-use presets for common scenarios
VehiclePresets.standardCar        // Blue car, normal size
VehiclePresets.emergencyAmbulance // White ambulance, flashing
VehiclePresets.activePolice       // Police car with lights
VehiclePresets.farmTractor        // Green tractor with smoke
VehiclePresets.safetyBus          // Yellow school bus
VehiclePresets.crashedCar         // Red car with crash effects
```

## 🧠 Accessible Design

This package was designed with accessibility and focus in mind:

- **Immediate Visual Feedback**: Every interaction has instant visual response
- **High Contrast Elements**: Important features stand out clearly
- **Predictable Animations**: Consistent, non-distracting movement patterns
- **Clear Purpose**: Each vehicle type has distinct, logical behaviors
- **Sensory Considerations**: Calming colors, optional effects

## 📱 Platform Support

- ✅ **Android**
- ✅ **iOS** 
- ✅ **Web**
- ✅ **Windows**
- ✅ **macOS**
- ✅ **Linux**

## 🔧 Advanced Usage

### Animation Control

```dart
class MyVehicleWidget extends StatefulWidget {
  @override
  _MyVehicleWidgetState createState() => _MyVehicleWidgetState();
}

class _MyVehicleWidgetState extends State<MyVehicleWidget> {
  bool _isEmergency = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TuesdaeVehicle(
          type: VehicleType.ambulance,
          config: VehicleConfig(
            primaryColor: Colors.white,
            size: 30.0,
            isFlashing: _isEmergency,
            direction: VehicleDirection.north,
          ),
        ),
        ElevatedButton(
          onPressed: () => setState(() => _isEmergency = !_isEmergency),
          child: Text(_isEmergency ? 'Turn Off Siren' : 'Emergency Mode'),
        ),
      ],
    );
  }
}
```

### Traffic Simulation

```dart
class TrafficIntersection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // North-bound traffic
        Positioned(
          top: 50,
          left: 200,
          child: TuesdaeVehicle.preset(
            type: VehicleType.regular,
            config: VehiclePresets.standardCar.copyWith(
              direction: VehicleDirection.south,
            ),
          ),
        ),
        
        // Emergency vehicle
        Positioned(
          top: 100,
          left: 150,
          child: TuesdaeVehicle.ambulance(
            config: VehiclePresets.emergencyAmbulance.copyWith(
              direction: VehicleDirection.east,
              isFlashing: true,
            ),
          ),
        ),
        
        // School zone
        Positioned(
          top: 200,
          left: 100,
          child: TuesdaeVehicle.schoolBus(),
        ),
      ],
    );
  }
}
```

## 🎯 Perfect For

- **Traffic Management Games** (like Tuesdae Rush!)
- **Educational Apps** (teaching traffic safety)
- **City Simulation Games**
- **Emergency Response Training**
- **Kids' Transportation Apps**
- **Accessible Learning Tools**

## 🤝 Contributing

We love contributions! Please feel free to:

- 🐛 Report bugs
- 💡 Suggest new features
- 🚗 Add new vehicle types
- 📚 Improve documentation
- 🎨 Enhance animations

## 📄 License

MIT License - feel free to use in your projects!

## 🌟 Related Projects

- **[Tuesdae Rush](https://github.com/rudi-q/tuesdae-rush-flutter)** - The original accessible traffic game
- Built with ❤️ for everyone

---

*Tuesdae Assets - Flutter vehicle widgets*
