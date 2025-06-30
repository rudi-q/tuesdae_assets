import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'vehicle_types.dart';

/// CustomPainter that renders vehicles with all their special effects
class VehiclePainter extends CustomPainter {
  final VehicleType type;
  final VehicleConfig config;
  final double animationValue;

  const VehiclePainter({
    required this.type,
    required this.config,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    // Apply rotation transformation
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(_getRotationAngle());

    double carWidth = _getVehicleWidth();
    double carHeight = _getVehicleHeight();

    _drawVehicleBody(canvas, carWidth, carHeight);

    if (config.showEffects) {
      _drawVehicleEffects(canvas, carWidth, carHeight);
    }

    if (config.isCrashed) {
      _drawCrashEffects(canvas);
    }

    canvas.restore();
  }

  double _getRotationAngle() {
    switch (config.direction) {
      case VehicleDirection.south:
        return 0;
      case VehicleDirection.north:
        return math.pi;
      case VehicleDirection.east:
        return -math.pi / 2;
      case VehicleDirection.west:
        return math.pi / 2;
    }
  }

  double _getVehicleWidth() {
    switch (type) {
      case VehicleType.schoolBus:
        return config.size * 1.5;
      default:
        return config.size;
    }
  }

  double _getVehicleHeight() {
    switch (type) {
      case VehicleType.schoolBus:
        return config.size * 3;
      default:
        return config.size * 1.4;
    }
  }

  void _drawVehicleBody(Canvas canvas, double carWidth, double carHeight) {
    Color bodyColor = config.isCrashed ? Colors.red : config.primaryColor;

    // Car body
    final carPaint = Paint()..color = bodyColor;
    final carStrokePaint =
        Paint()
          ..color = const Color(0xFF1E1E1E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    RRect carBody = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: carWidth, height: carHeight),
      const Radius.circular(4),
    );
    canvas.drawRRect(carBody, carPaint);
    canvas.drawRRect(carBody, carStrokePaint);

    // Front windshield
    final windshieldPaint =
        Paint()..color = const Color(0xFFC8DCFF).withValues(alpha: 0.7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(0, -carHeight / 4),
          width: carWidth * 0.8,
          height: carHeight / 3,
        ),
        const Radius.circular(2),
      ),
      windshieldPaint,
    );

    // Rear windshield
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(0, carHeight / 4),
          width: carWidth * 0.8,
          height: carHeight / 3,
        ),
        const Radius.circular(2),
      ),
      windshieldPaint,
    );

    // Headlights (white - at front)
    final headlightPaint = Paint()..color = const Color(0xFFFFFFC8);
    canvas.drawCircle(
      Offset(-carWidth / 3, -carHeight / 2 + 2),
      2,
      headlightPaint,
    );
    canvas.drawCircle(
      Offset(carWidth / 3, -carHeight / 2 + 2),
      2,
      headlightPaint,
    );

    // Taillights (red - at rear)
    final taillightPaint = Paint()..color = const Color(0xFFFF3232);
    canvas.drawCircle(
      Offset(-carWidth / 3, carHeight / 2 - 2),
      1.5,
      taillightPaint,
    );
    canvas.drawCircle(
      Offset(carWidth / 3, carHeight / 2 - 2),
      1.5,
      taillightPaint,
    );
  }

  void _drawVehicleEffects(Canvas canvas, double carWidth, double carHeight) {
    switch (type) {
      case VehicleType.ambulance:
        _drawAmbulanceEffects(canvas, carWidth, carHeight);
        break;
      case VehicleType.police:
        _drawPoliceEffects(canvas, carWidth, carHeight);
        break;
      case VehicleType.tractor:
        _drawTractorEffects(canvas, carWidth, carHeight);
        break;
      case VehicleType.schoolBus:
        _drawSchoolBusEffects(canvas, carWidth, carHeight);
        break;
      default:
        break;
    }
  }

  void _drawAmbulanceEffects(Canvas canvas, double carWidth, double carHeight) {
    // Flashing lights animation
    double time = animationValue * 2 * math.pi * config.animationSpeed;
    double redAlpha = config.isFlashing ? 0.8 + 0.2 * math.sin(time * 8) : 0.8;
    double blueAlpha =
        config.isFlashing ? 0.8 + 0.2 * math.sin(time * 8 + math.pi) : 0.8;

    // Red light (left side)
    final redLightPaint =
        Paint()..color = Colors.red.withValues(alpha: redAlpha);
    canvas.drawCircle(const Offset(-8, -16), 3, redLightPaint);

    // Blue light (right side)
    final blueLightPaint =
        Paint()..color = Colors.blue.withValues(alpha: blueAlpha);
    canvas.drawCircle(const Offset(8, -16), 3, blueLightPaint);

    // Medical cross symbol
    final crossPaint =
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2;
    canvas.drawLine(const Offset(-4, 0), const Offset(4, 0), crossPaint);
    canvas.drawLine(const Offset(0, -4), const Offset(0, 4), crossPaint);

    // Light beams when flashing
    if (config.isFlashing) {
      if (redAlpha > 0.9) {
        final beamPaint = Paint()..color = Colors.red.withValues(alpha: 0.4);
        canvas.drawCircle(const Offset(-8, -16), 15, beamPaint);
      }
      if (blueAlpha > 0.9) {
        final beamPaint = Paint()..color = Colors.blue.withValues(alpha: 0.4);
        canvas.drawCircle(const Offset(8, -16), 15, beamPaint);
      }
    }
  }

  void _drawPoliceEffects(Canvas canvas, double carWidth, double carHeight) {
    // Faster flashing lights
    double time = animationValue * 2 * math.pi * config.animationSpeed;
    double redAlpha = config.isFlashing ? 0.9 + 0.1 * math.sin(time * 12) : 0.9;
    double blueAlpha =
        config.isFlashing ? 0.9 + 0.1 * math.sin(time * 12 + math.pi) : 0.9;

    // Red light (left side)
    final redLightPaint =
        Paint()..color = Colors.red.withValues(alpha: redAlpha);
    canvas.drawCircle(const Offset(-6, -16), 2.5, redLightPaint);

    // Blue light (right side)
    final blueLightPaint =
        Paint()..color = Colors.blue.withValues(alpha: blueAlpha);
    canvas.drawCircle(const Offset(6, -16), 2.5, blueLightPaint);

    // Police badge (star)
    final badgePaint =
        Paint()..color = const Color(0xFFFFD700).withValues(alpha: 0.6);
    canvas.drawCircle(Offset.zero, 3, badgePaint);

    // "POLICE" text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'POLICE',
        style: TextStyle(
          color: Colors.white,
          fontSize: 6,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(-textPainter.width / 2, 5));

    // Aggressive light beams
    if (config.isFlashing) {
      if (redAlpha > 0.95) {
        final beamPaint = Paint()..color = Colors.red.withValues(alpha: 0.3);
        canvas.drawCircle(const Offset(-6, -16), 17.5, beamPaint);
      }
      if (blueAlpha > 0.95) {
        final beamPaint = Paint()..color = Colors.blue.withValues(alpha: 0.3);
        canvas.drawCircle(const Offset(6, -16), 17.5, beamPaint);
      }
    }
  }

  void _drawTractorEffects(Canvas canvas, double carWidth, double carHeight) {
    // Tractor treads
    final treadPaint =
        Paint()
          ..color = const Color(0xFF282828)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    // Left tread
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(-6, 0), width: 4, height: 12),
        const Radius.circular(1),
      ),
      treadPaint,
    );

    // Right tread
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(6, 0), width: 4, height: 12),
        const Radius.circular(1),
      ),
      treadPaint,
    );

    // Exhaust pipe
    final exhaustPaint = Paint()..color = const Color(0xFF141414);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(0, -18), width: 6, height: 6),
        const Radius.circular(2),
      ),
      exhaustPaint,
    );

    // Animated smoky exhaust
    double time = animationValue * 2 * math.pi * config.animationSpeed;
    double smokeAlpha = 0.3 + 0.2 * math.sin(time * 2);

    final smokePaint =
        Paint()..color = const Color(0xFF505050).withValues(alpha: smokeAlpha);
    canvas.drawCircle(const Offset(0, -22), 4, smokePaint);
    canvas.drawCircle(const Offset(3, -24), 3, smokePaint);
    canvas.drawCircle(const Offset(0, -26), 2, smokePaint);

    // "SLOW" warning text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'SLOW',
        style: TextStyle(
          color: Color(0xFFFFA500),
          fontSize: 6,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(-textPainter.width / 2, 5));
  }

  void _drawSchoolBusEffects(Canvas canvas, double carWidth, double carHeight) {
    double time = animationValue * 2 * math.pi * config.animationSpeed;
    double busHalfLength = carHeight / 2;

    // Black stripes
    final stripePaint = Paint()..color = Colors.black;
    canvas.drawRect(
      Rect.fromLTWH(-busHalfLength, -8, carHeight, 2),
      stripePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(-busHalfLength, 8, carHeight, 2),
      stripePaint,
    );

    // Animated stop sign arm
    if (math.sin(time * 4) > 0.5) {
      final stopSignPaint = Paint()..color = Colors.red;
      final stopSignStrokePaint =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1;

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(busHalfLength - 2, 0),
          width: 12,
          height: 8,
        ),
        stopSignPaint,
      );
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(busHalfLength - 2, 0),
          width: 12,
          height: 8,
        ),
        stopSignStrokePaint,
      );

      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'STOP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(busHalfLength - 8, -2));
    }

    // Flashing red safety lights
    double redAlpha = config.isFlashing ? 0.8 + 0.2 * math.sin(time * 6) : 0.8;
    final flashingPaint =
        Paint()..color = Colors.red.withValues(alpha: redAlpha);

    canvas.drawCircle(Offset(-busHalfLength + 2, -6), 2, flashingPaint);
    canvas.drawCircle(Offset(-busHalfLength + 2, 6), 2, flashingPaint);
    canvas.drawCircle(Offset(busHalfLength - 2, -6), 2, flashingPaint);
    canvas.drawCircle(Offset(busHalfLength - 2, 6), 2, flashingPaint);

    // Text labels
    final schoolTextPainter = TextPainter(
      text: const TextSpan(
        text: 'SCHOOL BUS',
        style: TextStyle(
          color: Colors.black,
          fontSize: 6,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    schoolTextPainter.layout();
    schoolTextPainter.paint(canvas, Offset(-schoolTextPainter.width / 2, -3));

    final cautionTextPainter = TextPainter(
      text: const TextSpan(
        text: 'CAUTION',
        style: TextStyle(
          color: Colors.red,
          fontSize: 4,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    cautionTextPainter.layout();
    cautionTextPainter.paint(canvas, Offset(-cautionTextPainter.width / 2, 6));

    // Light beams when flashing
    if (config.isFlashing && redAlpha > 0.9) {
      final beamPaint = Paint()..color = Colors.red.withValues(alpha: 0.4);
      canvas.drawCircle(Offset(-busHalfLength + 2, 0), 12.5, beamPaint);
      canvas.drawCircle(Offset(busHalfLength - 2, 0), 12.5, beamPaint);
    }
  }

  void _drawCrashEffects(Canvas canvas) {
    // Explosion sparks radiating from center
    for (int i = 0; i < 8; i++) {
      double angle = (i / 8) * 2 * math.pi;
      double sparkX = math.cos(angle) * 15;
      double sparkY = math.sin(angle) * 15;

      final sparkPaint =
          Paint()
            ..color = const Color(0xFFFF9600)
            ..strokeWidth = 2;
      canvas.drawLine(Offset.zero, Offset(sparkX, sparkY), sparkPaint);

      final sparkDotPaint = Paint()..color = const Color(0xFFFFC800);
      canvas.drawCircle(Offset(sparkX, sparkY), 1.5, sparkDotPaint);
    }

    // Central explosion glow
    final explosionPaint =
        Paint()..color = const Color(0xFFFF6400).withValues(alpha: 0.6);
    canvas.drawCircle(Offset.zero, 8, explosionPaint);
  }

  @override
  bool shouldRepaint(covariant VehiclePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.config != config ||
        oldDelegate.type != type;
  }
}
