import 'package:flutter/material.dart';

/// Types of vehicles available in the Tuesdae Assets package
enum VehicleType {
  /// Standard passenger car
  regular,

  /// Emergency ambulance with flashing lights and medical cross
  ambulance,

  /// Police car with flashing lights and badge
  police,

  /// Agricultural tractor with treads and exhaust smoke
  tractor,

  /// School bus with stop sign and safety lights
  schoolBus,

  /// Impatient car (regular car with attitude)
  impatient,
}

/// Direction the vehicle is facing/moving
enum VehicleDirection {
  /// Vehicle pointing upward (north)
  north,

  /// Vehicle pointing downward (south)
  south,

  /// Vehicle pointing rightward (east)
  east,

  /// Vehicle pointing leftward (west)
  west,
}

/// Configuration for vehicle appearance and behavior
class VehicleConfig {
  /// Primary color of the vehicle body
  final Color primaryColor;

  /// Size of the vehicle (width/height will be calculated proportionally)
  final double size;

  /// Direction the vehicle is facing
  final VehicleDirection direction;

  /// Whether emergency lights should be flashing (ambulance/police)
  final bool isFlashing;

  /// Whether the vehicle appears crashed (red color, sparks)
  final bool isCrashed;

  /// Whether to show special effects (exhaust, stop signs, etc.)
  final bool showEffects;

  /// Animation speed multiplier for effects (1.0 = normal speed)
  final double animationSpeed;

  const VehicleConfig({
    required this.primaryColor,
    this.size = 20.0,
    this.direction = VehicleDirection.north,
    this.isFlashing = false,
    this.isCrashed = false,
    this.showEffects = true,
    this.animationSpeed = 1.0,
  });

  /// Create a copy with modified properties
  VehicleConfig copyWith({
    Color? primaryColor,
    double? size,
    VehicleDirection? direction,
    bool? isFlashing,
    bool? isCrashed,
    bool? showEffects,
    double? animationSpeed,
  }) {
    return VehicleConfig(
      primaryColor: primaryColor ?? this.primaryColor,
      size: size ?? this.size,
      direction: direction ?? this.direction,
      isFlashing: isFlashing ?? this.isFlashing,
      isCrashed: isCrashed ?? this.isCrashed,
      showEffects: showEffects ?? this.showEffects,
      animationSpeed: animationSpeed ?? this.animationSpeed,
    );
  }
}

/// Preset vehicle configurations for common use cases
class VehiclePresets {
  /// Standard blue car facing north
  static const VehicleConfig standardCar = VehicleConfig(
    primaryColor: Color(0xFF3498DB),
    size: 20.0,
    direction: VehicleDirection.north,
  );

  /// Emergency ambulance with flashing lights
  static const VehicleConfig emergencyAmbulance = VehicleConfig(
    primaryColor: Colors.white,
    size: 24.0,
    direction: VehicleDirection.north,
    isFlashing: true,
    showEffects: true,
  );

  /// Active police car with flashing lights
  static const VehicleConfig activePolice = VehicleConfig(
    primaryColor: Color(0xFF00008B),
    size: 22.0,
    direction: VehicleDirection.north,
    isFlashing: true,
    showEffects: true,
  );

  /// Slow-moving tractor with exhaust
  static const VehicleConfig farmTractor = VehicleConfig(
    primaryColor: Color(0xFF228B22),
    size: 18.0,
    direction: VehicleDirection.north,
    showEffects: true,
  );

  /// School bus with safety features
  static const VehicleConfig safetyBus = VehicleConfig(
    primaryColor: Color(0xFFFFFF00),
    size: 30.0,
    direction: VehicleDirection.north,
    showEffects: true,
  );

  /// Crashed vehicle with damage effects
  static const VehicleConfig crashedCar = VehicleConfig(
    primaryColor: Colors.red,
    size: 20.0,
    direction: VehicleDirection.north,
    isCrashed: true,
    showEffects: true,
  );
}
