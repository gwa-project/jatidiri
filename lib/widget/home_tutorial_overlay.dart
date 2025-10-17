import 'package:flutter/material.dart';

class HomeTutorialOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const HomeTutorialOverlay({
    super.key,
    required this.onComplete,
  });

  @override
  State<HomeTutorialOverlay> createState() => _HomeTutorialOverlayState();
}

class _HomeTutorialOverlayState extends State<HomeTutorialOverlay> {
  int _currentStep = 0;
  final int _totalSteps = 3;

  // 🎨 PENGATURAN POSISI - Ubah nilai ini untuk menyesuaikan posisi tooltip
  // Step 1 - Profile Tooltip (pojok kanan atas)
  static const double step1Top = 80;      // Jarak dari atas (makin besar = makin bawah)
  static const double step1Right = 20;    // Jarak dari kanan (makin besar = makin kiri)
  static const double step1Width = 200;   // Lebar tooltip

  // Step 2 - Main Card Bubble (tengah layar)
  static const double step2Top = 180;     // Jarak dari atas (makin besar = makin bawah)
  static const double step2Left = 16;     // Jarak dari kiri
  static const double step2Right = 16;    // Jarak dari kanan

  // Step 3 - Bottom Navigation Popup
  static const double step3Bottom = 120;  // Jarak dari bawah (makin besar = makin atas)
  static const double step3WidthPercent = 0.8; // 80% dari lebar layar

  // Spotlight Area untuk Step 1 (Area Profile + Nama)
  static const double spotlightLeft = 10;   // Jarak dari kiri
  static const double spotlightTop = 20;    // Jarak dari atas (SafeArea top + 20px padding)
  static const double spotlightWidth = 190; // Lebar area terang (profile + nama + good morning)
  static const double spotlightHeight = 60; // Tinggi area terang

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Dark backdrop with cutout for spotlight
          if (_currentStep == 0)
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: _SpotlightPainter(
                spotlightRect: Rect.fromLTWH(
                  spotlightLeft,
                  spotlightTop,
                  spotlightWidth,
                  spotlightHeight,
                ),
                borderRadius: 12,
              ),
            )
          else
            Container(color: Colors.black.withOpacity(0.7)),

          // Step content
          if (_currentStep == 0) _buildStep1(),
          if (_currentStep == 1) _buildStep2(),
          if (_currentStep == 2) _buildStep3(),
        ],
      ),
    );
  }

  // Step 1: Profile Guide
  Widget _buildStep1() {
    return Positioned(
      top: step1Top,
      right: step1Right,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Character illustration (ilustrasi karakter)
          Image.asset(
            'assets/images/homescreen-guide-1.png',
            width: 120,
            height: 120,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(width: 120, height: 120); // Placeholder jika error
            },
          ),
          const SizedBox(height: 8),
          // Arrow pointing up (di atas tooltip, mengarah ke nama)
          Padding(
            padding: const EdgeInsets.only(right: 140), // Lebih ke kiri untuk mengarah ke nama
            child: CustomPaint(
              size: const Size(20, 10),
              painter: _ArrowPainter(direction: ArrowDirection.up),
            ),
          ),
          // Tooltip bubble
          Container(
            width: step1Width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Klik fotomu di atas buat atur info diri.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1 of $_totalSteps',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                    GestureDetector(
                      onTap: _nextStep,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6464FA),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 2: Main Card Guide
  Widget _buildStep2() {
    return Positioned(
      top: step2Top,
      left: step2Left,
      right: step2Right,
      child: Column(
        children: [
          // Gradient bubble with character
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B8BFF), Color(0xFFB8B8FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Siap Cari Tahu Siapa Dirimu?',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Yuk, ikuti tes psikologi dan temukan potensimu.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2 of $_totalSteps',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                          GestureDetector(
                            onTap: _nextStep,
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Character illustration
                Image.asset(
                  'assets/images/survei.png',
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person_outline,
                      size: 60,
                      color: Colors.white,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 3: Bottom Navigation Guide
  Widget _buildStep3() {
    return Positioned(
      bottom: step3Bottom,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * step3WidthPercent,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Cek Bagaimana Hasil Tesmu Disini!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '3 of $_totalSteps',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onTap: _nextStep,
                    child: const Text(
                      'Finished',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6464FA),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Arrow Painter
class _ArrowPainter extends CustomPainter {
  final ArrowDirection direction;

  _ArrowPainter({required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    if (direction == ArrowDirection.down) {
      // Arrow pointing down
      path.moveTo(size.width / 2, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else {
      // Arrow pointing up
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum ArrowDirection { up, down }

// Spotlight Painter - untuk highlight area tertentu
class _SpotlightPainter extends CustomPainter {
  final Rect spotlightRect;
  final double borderRadius;

  _SpotlightPainter({
    required this.spotlightRect,
    this.borderRadius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background gelap
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // Path untuk background penuh
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Path untuk spotlight (area terang)
    final spotlightPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          spotlightRect,
          Radius.circular(borderRadius),
        ),
      );

    // Subtract spotlight dari background (buat hole/cutout)
    final finalPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      spotlightPath,
    );

    // Draw background gelap dengan hole
    canvas.drawPath(finalPath, backgroundPaint);

    // Draw border di sekitar spotlight (optional, untuk emphasis)
    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        spotlightRect,
        Radius.circular(borderRadius),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
