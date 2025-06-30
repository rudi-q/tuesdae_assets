import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      title: 'Tuesdae Assets - Vehicle Widgets',
      theme: _buildTheme(),
      home: const VehicleShowcase(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.light,
      ),
      fontFamily: 'SF Pro Display',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class VehicleShowcase extends StatefulWidget {
  const VehicleShowcase({super.key});

  @override
  VehicleShowcaseState createState() => VehicleShowcaseState();
}

class VehicleShowcaseState extends State<VehicleShowcase>
    with TickerProviderStateMixin {
  bool _emergencyMode = false;
  VehicleDirection _direction = VehicleDirection.north;
  double _size = 30.0;
  Color _carColor = const Color(0xFF6366F1);
  late AnimationController _heroAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutCubic,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutCubic,
    ));
    
    _heroAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardAnimationController.forward();
    });
  }
  
  @override
  void dispose() {
    _heroAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
              Color(0xFF6B73FF),
              Color(0xFF9A9CE6),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeroSection(),
                const SizedBox(height: 20),
                _buildAnimatedContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Hero title with animation
          AnimatedBuilder(
            animation: _heroAnimationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _heroAnimationController.value,
                child: Opacity(
                  opacity: _heroAnimationController.value,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Text(
                          '🚗 TUESDAE ASSETS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Beautiful Vehicle Widgets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Accessible, animated vehicles for Flutter\nPerfect for games, simulations & educational apps',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          // Hero vehicles showcase
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHeroVehicle(
                  const TuesdaeVehicle.ambulance(
                    config: VehicleConfig(
                      primaryColor: Colors.white,
                      size: 40,
                      isFlashing: true,
                    ),
                  ),
                ),
                _buildHeroVehicle(
                  const TuesdaeVehicle.police(
                    config: VehicleConfig(
                      primaryColor: Color(0xFF1E3A8A),
                      size: 40,
                      isFlashing: true,
                    ),
                  ),
                ),
                _buildHeroVehicle(
                  const TuesdaeVehicle.schoolBus(
                    config: VehicleConfig(
                      primaryColor: Color(0xFFFBBF24),
                      size: 40,
                      showEffects: true,
                    ),
                  ),
                ),
                _buildHeroVehicle(
                  const TuesdaeVehicle.tractor(
                    config: VehicleConfig(
                      primaryColor: Color(0xFF16A34A),
                      size: 40,
                      showEffects: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroVehicle(Widget vehicle) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Center(child: vehicle),
    );
  }

  Widget _buildAnimatedContent() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildModernVehicleShowcase(),
                  const SizedBox(height: 24),
                  _buildModernInteractiveDemo(),
                  const SizedBox(height: 24),
                  _buildModernTrafficDemo(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernVehicleShowcase() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Vehicle Collection',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildModernVehicleCard(
                  '🚗 Regular Car',
                  'Standard passenger vehicle',
                  const TuesdaeVehicle.preset(
                    type: VehicleType.regular,
                    config: VehicleConfig(
                            primaryColor: Color(0xFF3B82F6),
                            size: 50,
                    ),
                  ),
                  const Color(0xFF3B82F6),
                ),
                _buildModernVehicleCard(
                  '🚑 Ambulance',
                  'Emergency response vehicle',
                  const TuesdaeVehicle.ambulance(
                    config: VehicleConfig(
                      primaryColor: Colors.white,
                            size: 50,
                      isFlashing: true,
                    ),
                  ),
                  const Color(0xFFEF4444),
                ),
                _buildModernVehicleCard(
                  '🚓 Police Car',
                  'Law enforcement vehicle',
                  const TuesdaeVehicle.police(
                    config: VehicleConfig(
                      primaryColor: Color(0xFF1E3A8A),
                            size: 50,
                      isFlashing: true,
                    ),
                  ),
                  const Color(0xFF1E3A8A),
                ),
                _buildModernVehicleCard(
                  '🚜 Tractor',
                  'Farm vehicle with effects',
                  const TuesdaeVehicle.tractor(
                    config: VehicleConfig(
                      primaryColor: Color(0xFF16A34A),
                            size: 50,
                      showEffects: true,
                    ),
                  ),
                  const Color(0xFF16A34A),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernVehicleCard(
    String title,
    String description,
    Widget vehicle,
    Color accentColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: vehicle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInteractiveDemo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Live Customization',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildModernToggle('Emergency Lights', _emergencyMode, (value) {
                        setState(() => _emergencyMode = value);
                        HapticFeedback.lightImpact();
                      }),
                      const SizedBox(height: 20),
                      const Text(
                        'Direction',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: VehicleDirection.values.map((dir) {
                          return _buildDirectionChip(dir);
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Size: ${_size.round()}px',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF06B6D4),
                          thumbColor: const Color(0xFF06B6D4),
                          overlayColor: const Color(0xFF06B6D4).withValues(alpha: 0.2),
                        ),
                        child: Slider(
                          value: _size,
                          min: 20,
                          max: 60,
                          divisions: 8,
                          onChanged: (value) {
                            setState(() => _size = value);
                            HapticFeedback.selectionClick();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Color Theme',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        children: [
                          const Color(0xFF6366F1),
                          const Color(0xFFEF4444),
                          const Color(0xFF10B981),
                          const Color(0xFFF59E0B),
                          const Color(0xFF8B5CF6),
                          const Color(0xFF06B6D4),
                        ].map((color) => _buildColorOption(color)).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _carColor.withValues(alpha: 0.1),
                          _carColor.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _carColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                '🚗 Vehicle tapped! Ready to integrate?',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              backgroundColor: _carColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        child: TuesdaeVehicle(
                          type: VehicleType.ambulance,
                          config: VehicleConfig(
                            primaryColor: _carColor,
                            size: _size,
                            direction: _direction,
                            isFlashing: _emergencyMode,
                            showEffects: true,
                          ),
                        ),
                      ),
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

  Widget _buildModernToggle(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF06B6D4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Widget _buildDirectionChip(VehicleDirection dir) {
    final isSelected = _direction == dir;
    return GestureDetector(
      onTap: () {
        setState(() => _direction = dir);
        HapticFeedback.selectionClick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF06B6D4) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF06B6D4) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          dir.name.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    final isSelected = _carColor == color;
    return GestureDetector(
      onTap: () {
        setState(() => _carColor = color);
        HapticFeedback.lightImpact();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              )
            : null,
      ),
    );
  }

  Widget _buildModernTrafficDemo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.traffic,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Traffic Simulation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E293B),
                    Color(0xFF334155),
                    Color(0xFF475569),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Clean city background
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const RadialGradient(
                          center: Alignment.center,
                          radius: 1.2,
                          colors: [
                            Color(0xFF374151),
                            Color(0xFF1F2937),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Modern road layout
                  Positioned.fill(child: CustomPaint(painter: CleanRoadPainter())),
                  
                  // Vehicles positioned more naturally
                  const Positioned(
                    top: 60,
                    left: 200,
                    child: TuesdaeVehicle(
                      type: VehicleType.regular,
                      config: VehicleConfig(
                        primaryColor: Color(0xFF3B82F6),
                        size: 32,
                        direction: VehicleDirection.south,
                      ),
                    ),
                  ),
                  
                  const Positioned(
                    top: 120,
                    left: 80,
                    child: TuesdaeVehicle.ambulance(
                      config: VehicleConfig(
                        primaryColor: Colors.white,
                        size: 34,
                        direction: VehicleDirection.east,
                        isFlashing: true,
                      ),
                    ),
                  ),
                  
                  const Positioned(
                    top: 200,
                    left: 200,
                    child: TuesdaeVehicle.schoolBus(
                      config: VehicleConfig(
                        primaryColor: Color(0xFFFBBF24),
                        size: 38,
                        direction: VehicleDirection.north,
                        showEffects: true,
                      ),
                    ),
                  ),
                  
                  const Positioned(
                    top: 120,
                    right: 80,
                    child: TuesdaeVehicle.police(
                      config: VehicleConfig(
                        primaryColor: Color(0xFF1E3A8A),
                        size: 34,
                        direction: VehicleDirection.west,
                        isFlashing: true,
                      ),
                    ),
                  ),
                  
                  const Positioned(
                    top: 40,
                    left: 125,
                    child: TuesdaeVehicle.tractor(
                      config: VehicleConfig(
                        primaryColor: Color(0xFF16A34A),
                        size: 30,
                        direction: VehicleDirection.south,
                        showEffects: true,
                      ),
                    ),
                  ),
                  
                  // City elements for context
                  Positioned(
                    top: 20,
                    left: 20,
                    child: _buildCityBuilding(30, const Color(0xFF4B5563)),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: _buildCityBuilding(40, const Color(0xFF6B7280)),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: _buildCityBuilding(35, const Color(0xFF374151)),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 30,
                    child: _buildCityBuilding(45, const Color(0xFF4B5563)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.2),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Color(0xFF16A34A),
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Perfect for traffic games, city simulations, educational apps, and emergency response training!',
                      style: TextStyle(
                        color: Color(0xFF166534),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityBuilding(double height, Color color) {
    return Container(
      width: 20,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 4),
          // Building windows
          for (int i = 0; i < (height / 12).floor(); i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.yellow.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
        ],
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

class ModernRoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Main road surface
    final roadPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2D3748),
          Color(0xFF1A202C),
          Color(0xFF2D3748),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Road line paint
    final linePaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final dashedLinePaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Intersection background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height,
        ),
        const Radius.circular(12),
      ),
      roadPaint,
    );

    // Horizontal road
    final horizontalRoad = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, size.height / 2 - 30, size.width, 60),
      const Radius.circular(4),
    );
    canvas.drawRRect(horizontalRoad, roadPaint);

    // Vertical road
    final verticalRoad = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width / 2 - 30, 0, 60, size.height),
      const Radius.circular(4),
    );
    canvas.drawRRect(verticalRoad, roadPaint);

    // Road borders
    final borderPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(horizontalRoad, borderPaint);
    canvas.drawRRect(verticalRoad, borderPaint);

    // Center dashed lines - Horizontal
    for (double x = 0; x < size.width; x += 20) {
      if (x < size.width / 2 - 40 || x > size.width / 2 + 40) {
        canvas.drawLine(
          Offset(x, size.height / 2),
          Offset(x + 10, size.height / 2),
          dashedLinePaint,
        );
      }
    }

    // Center dashed lines - Vertical
    for (double y = 0; y < size.height; y += 20) {
      if (y < size.height / 2 - 40 || y > size.height / 2 + 40) {
        canvas.drawLine(
          Offset(size.width / 2, y),
          Offset(size.width / 2, y + 10),
          dashedLinePaint,
        );
      }
    }

    // Lane dividers
    canvas.drawLine(
      Offset(20, size.height / 2 - 15),
      Offset(size.width - 20, size.height / 2 - 15),
      linePaint,
    );
    canvas.drawLine(
      Offset(20, size.height / 2 + 15),
      Offset(size.width - 20, size.height / 2 + 15),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 - 15, 20),
      Offset(size.width / 2 - 15, size.height - 20),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 + 15, 20),
      Offset(size.width / 2 + 15, size.height - 20),
      linePaint,
    );

    // Crosswalk stripes
    final crosswalkPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 4;

    for (int i = 0; i < 8; i++) {
      double x = size.width / 2 - 40 + (i * 10);
      canvas.drawLine(
        Offset(x, size.height / 2 - 30),
        Offset(x, size.height / 2 + 30),
        crosswalkPaint,
      );
    }

    // Stop lines
    final stopLinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;

    // Horizontal stop lines
    canvas.drawLine(
      Offset(size.width / 2 - 40, size.height / 2 - 30),
      Offset(size.width / 2 - 40, size.height / 2 + 30),
      stopLinePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 + 40, size.height / 2 - 30),
      Offset(size.width / 2 + 40, size.height / 2 + 30),
      stopLinePaint,
    );

    // Vertical stop lines
    canvas.drawLine(
      Offset(size.width / 2 - 30, size.height / 2 - 40),
      Offset(size.width / 2 + 30, size.height / 2 - 40),
      stopLinePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 - 30, size.height / 2 + 40),
      Offset(size.width / 2 + 30, size.height / 2 + 40),
      stopLinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CleanRoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Clean modern road surface with subtle gradient
    final roadPaint = Paint()
      ..color = const Color(0xFF2C3E50);

    final centerLinePaint = Paint()
      ..color = const Color(0xFFF39C12)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final lanePaint = Paint()
      ..color = const Color(0xFFF39C12)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Main intersection area
    final roadRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );
    canvas.drawRRect(roadRect, roadPaint);

    // Horizontal road
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size.height / 2 - 35, size.width, 70),
        const Radius.circular(8),
      ),
      roadPaint,
    );

    // Vertical road
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - 35, 0, 70, size.height),
        const Radius.circular(8),
      ),
      roadPaint,
    );

    // Simple center lines - horizontal
    canvas.drawLine(
      Offset(30, size.height / 2),
      Offset(size.width / 2 - 40, size.height / 2),
      centerLinePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 + 40, size.height / 2),
      Offset(size.width - 30, size.height / 2),
      centerLinePaint,
    );

    // Simple center lines - vertical
    canvas.drawLine(
      Offset(size.width / 2, 30),
      Offset(size.width / 2, size.height / 2 - 40),
      centerLinePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2 + 40),
      Offset(size.width / 2, size.height - 30),
      centerLinePaint,
    );

    // Lane markers
    canvas.drawLine(
      Offset(30, size.height / 2 - 17),
      Offset(size.width - 30, size.height / 2 - 17),
      lanePaint,
    );
    canvas.drawLine(
      Offset(30, size.height / 2 + 17),
      Offset(size.width - 30, size.height / 2 + 17),
      lanePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 - 17, 30),
      Offset(size.width / 2 - 17, size.height - 30),
      lanePaint,
    );
    canvas.drawLine(
      Offset(size.width / 2 + 17, 30),
      Offset(size.width / 2 + 17, size.height - 30),
      lanePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
