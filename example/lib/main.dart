import 'package:flutter/material.dart';
import 'package:tuesdae_assets/vehicle_types.dart';
import 'package:tuesdae_assets/vehicle_widget.dart';

void main() {
  runApp(const TuesdaeAssetsExample());
}

class TuesdaeAssetsExample extends StatelessWidget {
  const TuesdaeAssetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuesdae Assets Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const VehicleShowcase(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VehicleShowcase extends StatefulWidget {
  const VehicleShowcase({super.key});

  @override
  VehicleShowcaseState createState() => VehicleShowcaseState();
}

class VehicleShowcaseState extends State<VehicleShowcase> {
  bool _emergencyMode = false;
  VehicleDirection _direction = VehicleDirection.north;
  double _size = 30.0;
  Color _carColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚗 Tuesdae Assets Demo'),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E7D32), Color(0xFF388E3C), Color(0xFF4CAF50)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildPresetVehicles(),
                const SizedBox(height: 30),
                _buildInteractiveDemo(),
                const SizedBox(height: 30),
                _buildTrafficDemo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accessible Vehicle Widgets',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Designed for clear visual feedback and predictable animations',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetVehicles() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🚑 Vehicle Types',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildVehicleCard(
                  'Regular Car',
                  const TuesdaeVehicle.preset(
                    type: VehicleType.regular,
                    config: VehiclePresets.standardCar,
                  ),
                  'Standard passenger vehicle',
                ),
                _buildVehicleCard(
                  'Ambulance',
                  const TuesdaeVehicle.ambulance(
                    config: VehiclePresets.emergencyAmbulance,
                  ),
                  'Emergency vehicle with flashing lights',
                ),
                _buildVehicleCard(
                  'Police Car',
                  const TuesdaeVehicle.police(
                    config: VehiclePresets.activePolice,
                  ),
                  'Law enforcement with badge',
                ),
                _buildVehicleCard(
                  'Tractor',
                  const TuesdaeVehicle.tractor(
                    config: VehiclePresets.farmTractor,
                  ),
                  'Farm vehicle with exhaust smoke',
                ),
                _buildVehicleCard(
                  'School Bus',
                  const TuesdaeVehicle.schoolBus(
                    config: VehiclePresets.safetyBus,
                  ),
                  'Safety vehicle with stop sign',
                ),
                _buildVehicleCard(
                  'Crashed Car',
                  const TuesdaeVehicle.preset(
                    type: VehicleType.regular,
                    config: VehiclePresets.crashedCar,
                  ),
                  'Vehicle with crash effects',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(String title, Widget vehicle, String description) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SizedBox(height: 60, child: Center(child: vehicle)),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎮 Interactive Demo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildToggleRow('Emergency Mode', _emergencyMode, (
                        value,
                      ) {
                        setState(() => _emergencyMode = value);
                      }),
                      const SizedBox(height: 10),
                      const Text(
                        'Direction:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        children:
                            VehicleDirection.values.map((dir) {
                              return FilterChip(
                                label: Text(dir.name),
                                selected: _direction == dir,
                                onSelected: (selected) {
                                  if (selected)
                                    setState(() => _direction = dir);
                                },
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Size: ${_size.round()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: _size,
                        min: 20,
                        max: 50,
                        divisions: 6,
                        onChanged: (value) => setState(() => _size = value),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Color:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        children:
                            [
                              Colors.blue,
                              Colors.red,
                              Colors.green,
                              Colors.orange,
                              Colors.purple,
                            ].map((color) {
                              return GestureDetector(
                                onTap: () => setState(() => _carColor = color),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border:
                                        _carColor == color
                                            ? Border.all(
                                              color: Colors.black,
                                              width: 3,
                                            )
                                            : null,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: TuesdaeVehicle(
                      type: VehicleType.ambulance,
                      config: VehicleConfig(
                        primaryColor: _carColor,
                        size: _size,
                        direction: _direction,
                        isFlashing: _emergencyMode,
                        showEffects: true,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vehicle tapped! 🚑')),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF4CAF50),
        ),
      ],
    );
  }

  Widget _buildTrafficDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🚦 Traffic Simulation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Road markings
                  Positioned.fill(child: CustomPaint(painter: RoadPainter())),
                  // Vehicles
                  const Positioned(
                    top: 20,
                    left: 90,
                    child: TuesdaeVehicle(
                      type: VehicleType.regular,
                      config: VehicleConfig(
                        primaryColor: Colors.blue,
                        size: 20,
                        direction: VehicleDirection.south,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 50,
                    child: TuesdaeVehicle.ambulance(
                      config: VehiclePresets.emergencyAmbulance.copyWith(
                        direction: VehicleDirection.east,
                        size: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 90,
                    child: TuesdaeVehicle.schoolBus(
                      config: VehiclePresets.safetyBus.copyWith(
                        direction: VehicleDirection.north,
                        size: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 50,
                    child: TuesdaeVehicle.police(
                      config: VehiclePresets.activePolice.copyWith(
                        direction: VehicleDirection.west,
                        isFlashing: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Perfect for traffic games, city simulations, and educational apps!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()..color = const Color(0xFF34495E);
    final linePaint =
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 2;

    // Horizontal road
    canvas.drawRect(
      Rect.fromLTWH(0, size.height / 2 - 20, size.width, 40),
      roadPaint,
    );

    // Vertical road
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 20, 0, 40, size.height),
      roadPaint,
    );

    // Center lines
    for (double x = 0; x < size.width; x += 30) {
      if (x < size.width / 2 - 30 || x > size.width / 2 + 30) {
        canvas.drawLine(
          Offset(x, size.height / 2),
          Offset(x + 15, size.height / 2),
          linePaint,
        );
      }
    }

    for (double y = 0; y < size.height; y += 30) {
      if (y < size.height / 2 - 30 || y > size.height / 2 + 30) {
        canvas.drawLine(
          Offset(size.width / 2, y),
          Offset(size.width / 2, y + 15),
          linePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
