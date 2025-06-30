import 'package:flutter/material.dart';

import 'vehicle_painter.dart';
import 'vehicle_types.dart';

/// A customizable animated vehicle widget for Flutter applications.
///
/// Example usage:
/// ```dart
/// TuesdaeVehicle(
///   type: VehicleType.ambulance,
///   config: VehiclePresets.emergencyAmbulance,
/// )
/// ```
class TuesdaeVehicle extends StatefulWidget {
  /// The type of vehicle to display
  final VehicleType type;

  /// Configuration for the vehicle's appearance and behavior
  final VehicleConfig config;

  /// Optional callback when the vehicle is tapped
  final VoidCallback? onTap;

  const TuesdaeVehicle({
    super.key,
    required this.type,
    required this.config,
    this.onTap,
  });

  /// Create a vehicle with preset configuration
  const TuesdaeVehicle.preset({
    super.key,
    required this.type,
    VehicleConfig? config,
    this.onTap,
  }) : config = config ?? VehiclePresets.standardCar;

  /// Create an ambulance with emergency configuration
  const TuesdaeVehicle.ambulance({super.key, VehicleConfig? config, this.onTap})
    : type = VehicleType.ambulance,
      config = config ?? VehiclePresets.emergencyAmbulance;

  /// Create a police car with active configuration
  const TuesdaeVehicle.police({super.key, VehicleConfig? config, this.onTap})
    : type = VehicleType.police,
      config = config ?? VehiclePresets.activePolice;

  /// Create a school bus with safety configuration
  const TuesdaeVehicle.schoolBus({super.key, VehicleConfig? config, this.onTap})
    : type = VehicleType.schoolBus,
      config = config ?? VehiclePresets.safetyBus;

  /// Create a tractor with farm configuration
  const TuesdaeVehicle.tractor({super.key, VehicleConfig? config, this.onTap})
    : type = VehicleType.tractor,
      config = config ?? VehiclePresets.farmTractor;

  @override
  State<TuesdaeVehicle> createState() => _TuesdaeVehicleState();
}

class _TuesdaeVehicleState extends State<TuesdaeVehicle>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Create animation controller for flashing lights and effects
    _animationController = AnimationController(
      duration: Duration(
        milliseconds: (1000 / widget.config.animationSpeed).round(),
      ),
      vsync: this,
    );

    // Start animation if effects are enabled
    if (widget.config.showEffects &&
        (widget.config.isFlashing || widget.type == VehicleType.tractor)) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(TuesdaeVehicle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation based on new configuration
    if (widget.config.showEffects &&
        (widget.config.isFlashing || widget.type == VehicleType.tractor)) {
      if (!_animationController.isAnimating) {
        _animationController.repeat();
      }
    } else {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate widget dimensions based on vehicle type and size
    double width = _calculateWidth();
    double height = _calculateHeight();

    Widget vehicleWidget = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          size: Size(width, height),
          painter: VehiclePainter(
            type: widget.type,
            config: widget.config,
            animationValue: _animationController.value,
          ),
        );
      },
    );

    // Add tap functionality if callback provided
    if (widget.onTap != null) {
      vehicleWidget = GestureDetector(
        onTap: widget.onTap,
        child: vehicleWidget,
      );
    }

    return SizedBox(width: width, height: height, child: vehicleWidget);
  }

  double _calculateWidth() {
    switch (widget.type) {
      case VehicleType.schoolBus:
        return widget.config.direction == VehicleDirection.east ||
                widget.config.direction == VehicleDirection.west
            ? widget.config.size *
                3 // Long school bus horizontally
            : widget.config.size * 1.5;
      default:
        return widget.config.direction == VehicleDirection.east ||
                widget.config.direction == VehicleDirection.west
            ? widget.config.size *
                1.4 // Elongated when horizontal
            : widget.config.size;
    }
  }

  double _calculateHeight() {
    switch (widget.type) {
      case VehicleType.schoolBus:
        return widget.config.direction == VehicleDirection.north ||
                widget.config.direction == VehicleDirection.south
            ? widget.config.size *
                3 // Long school bus vertically
            : widget.config.size * 1.5;
      default:
        return widget.config.direction == VehicleDirection.north ||
                widget.config.direction == VehicleDirection.south
            ? widget.config.size *
                1.4 // Elongated when vertical
            : widget.config.size;
    }
  }
}
