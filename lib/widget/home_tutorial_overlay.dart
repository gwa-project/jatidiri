import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HomeTutorialOverlay extends StatefulWidget {
  final VoidCallback onComplete;
  final Rect profileRect;
  final Rect mainCardRect;
  final Rect bottomNavRect;

  const HomeTutorialOverlay({
    super.key,
    required this.onComplete,
    required this.profileRect,
    required this.mainCardRect,
    required this.bottomNavRect,
  });

  @override
  State<HomeTutorialOverlay> createState() => _HomeTutorialOverlayState();
}

class _HomeTutorialOverlayState extends State<HomeTutorialOverlay> {
  int _currentStep = 0;
  final int _totalSteps = 3;

  static const double _step1TooltipWidth = 280; // Diperbesar supaya text + karakter muat
  static const double _step1ArrowWidth = 20;
  static const double _horizontalMargin = 16;
  static const double _profileSpotlightPadding = 12;
  static const double _mainCardSpotlightPadding = 20;
  static const double _bottomNavSpotlightPadding = 16;
  static const double _step3WidthPercent = 0.8;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      widget.onComplete();
    }
  }

  Rect? _spotlightForCurrentStep() {
    switch (_currentStep) {
      case 0:
        return widget.profileRect.inflate(_profileSpotlightPadding);
      case 1:
        return widget.mainCardRect.inflate(_mainCardSpotlightPadding);
      case 2:
        return widget.bottomNavRect.inflate(_bottomNavSpotlightPadding);
      default:
        return null;
    }
  }

  double _spotlightRadiusForCurrentStep() {
    switch (_currentStep) {
      case 0:
        return 20;
      case 1:
        return 24;
      case 2:
        return 30;
      default:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Rect? spotlightRect = _spotlightForCurrentStep();
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          if (spotlightRect != null)
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: _SpotlightPainter(
                spotlightRect: spotlightRect,
                borderRadius: _spotlightRadiusForCurrentStep(),
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
    final Rect targetRect = widget.profileRect;
    final Size screenSize = MediaQuery.of(context).size;

    final double minLeft = _horizontalMargin;
    final double maxLeft =
        screenSize.width - _step1TooltipWidth - _horizontalMargin;
    double left = targetRect.center.dx - (_step1TooltipWidth / 2);
    if (maxLeft >= minLeft) {
      left = left.clamp(minLeft, maxLeft).toDouble();
    } else {
      left = minLeft;
    }

    final double top = targetRect.bottom + 24; // Lebih ke bawah supaya tidak terlalu dekat dengan profile
    final double rawArrowLeft =
        (targetRect.center.dx - left) - (_step1ArrowWidth / 2);
    final double clampedArrowLeft = rawArrowLeft
        .clamp(12.0, _step1TooltipWidth - _step1ArrowWidth - 12.0)
        .toDouble();

    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        width: _step1TooltipWidth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10,
              left: clampedArrowLeft,
              child: CustomPaint(
                size: const Size(_step1ArrowWidth, 12),
                painter: _ArrowPainter(direction: ArrowDirection.up),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
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
                  const SizedBox(width: 16),
                  Transform.translate(
                    offset: const Offset(0, -79),
                    child: Image.asset(
                      'assets/images/homescreen-guide-1.png',
                      width: 68,
                      height: 68,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
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

  // Step 2: Main Card Guide
  Widget _buildStep2() {
    final Rect targetRect = widget.mainCardRect;
    final Size screenSize = MediaQuery.of(context).size;

    const double tooltipWidth = 300;
    final double availableWidth = screenSize.width - (_horizontalMargin * 2);
    final double bubbleWidth =
        availableWidth < tooltipWidth ? availableWidth : tooltipWidth;

    double left = targetRect.center.dx - (bubbleWidth / 2);
    final double minLeft = _horizontalMargin;
    final double maxLeft = screenSize.width - bubbleWidth - _horizontalMargin;
    if (maxLeft >= minLeft) {
      left = left.clamp(minLeft, maxLeft).toDouble();
    } else {
      left = minLeft;
    }

    double top = targetRect.bottom + 16;
    const double estimatedHeight = 220;
    if (top + estimatedHeight > screenSize.height - 32) {
      top = targetRect.top - estimatedHeight - 16;
      if (top < 32) {
        top = 32;
      }
    }

    final double rawArrowLeft =
        (targetRect.center.dx - left) - (_step1ArrowWidth / 2);
    final double clampedArrowLeft = rawArrowLeft
        .clamp(12.0, bubbleWidth - _step1ArrowWidth - 12.0)
        .toDouble();

    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        width: bubbleWidth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10,
              left: clampedArrowLeft,
              child: CustomPaint(
                size: const Size(_step1ArrowWidth, 12),
                painter: _ArrowPainter(direction: ArrowDirection.up),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF9EAFFF), Color(0xFF7B8EFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Siap Cari Tahu Siapa Dirimu?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
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
                            fontSize: 13,
                            color: Color(0xFFE5E8FF),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '2 of $_totalSteps',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11,
                                color: Color(0xFFE0E5FF),
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
                  const SizedBox(width: 16),
                  Transform.translate(
                    offset: const Offset(0, -18),
                    child: Image.asset(
                      'assets/images/homescreen-guide-2.png',
                      width: 88,
                      height: 88,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
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

  // Step 3: Bottom Navigation Guide
  Widget _buildStep3() {
    final Rect targetRect = widget.bottomNavRect;
    final Size screenSize = MediaQuery.of(context).size;

    final double distanceFromBottom = screenSize.height - targetRect.top;
    final double bottomOffset = distanceFromBottom + 80;
    final double horizontalInset =
        screenSize.width * (1 - _step3WidthPercent) / 2;

    return Positioned(
      bottom: bottomOffset,
      left: horizontalInset,
      right: horizontalInset,
      child: Container(
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
      ..color = Colors.black.withOpacity(0.45)
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

    // Draw background gelap dengan hole (area spotlight transparan 100%)
    canvas.drawPath(finalPath, backgroundPaint);

    // Soft glow around spotlight
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.outer, 24);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        spotlightRect.inflate(6),
        Radius.circular(borderRadius + 6),
      ),
      glowPaint,
    );

    // Draw border di sekitar spotlight (optional, untuk emphasis)
    final borderPaint = Paint()
      ..color = const Color(0xCCFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

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
