import 'package:flutter/material.dart';
import 'dart:math' as math;

class TutorialOverlay extends StatefulWidget {
  final List<TutorialStep> steps;
  final VoidCallback onComplete;

  const TutorialOverlay({
    super.key,
    required this.steps,
    required this.onComplete,
  });

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < widget.steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      widget.onComplete();
    }
  }

  void _skipTutorial() {
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.steps[_currentStep];

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Semi-transparent backdrop
          GestureDetector(
            onTap: () {}, // Prevent background interaction
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),

          // Spotlight effect (cutout hole)
          if (currentStep.targetRect != null)
            CustomPaint(
              painter: _SpotlightPainter(
                targetRect: currentStep.targetRect!,
                borderRadius: currentStep.spotlightBorderRadius,
              ),
              child: Container(),
            ),

          // Tooltip
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildTooltip(currentStep),
          ),
        ],
      ),
    );
  }

  Widget _buildTooltip(TutorialStep step) {
    return Positioned(
      top: step.tooltipPosition.dy,
      left: step.tooltipPosition.dx,
      child: _TooltipWidget(
        message: step.message,
        currentStep: _currentStep + 1,
        totalSteps: widget.steps.length,
        onNext: _nextStep,
        onSkip: _skipTutorial,
        arrowDirection: step.arrowDirection,
        width: step.tooltipWidth,
      ),
    );
  }
}

// Custom painter for spotlight effect
class _SpotlightPainter extends CustomPainter {
  final Rect targetRect;
  final double borderRadius;

  _SpotlightPainter({
    required this.targetRect,
    this.borderRadius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create rounded rectangle for spotlight
    final spotlightPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          targetRect,
          Radius.circular(borderRadius),
        ),
      );

    // Subtract spotlight from backdrop
    final finalPath = Path.combine(
      PathOperation.difference,
      path,
      spotlightPath,
    );

    canvas.drawPath(finalPath, paint);

    // Draw border around spotlight
    final borderPaint = Paint()
      ..color = const Color(0xFF6464FA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        targetRect,
        Radius.circular(borderRadius),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Tooltip Widget
class _TooltipWidget extends StatelessWidget {
  final String message;
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final ArrowDirection arrowDirection;
  final double width;

  const _TooltipWidget({
    required this.message,
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
    required this.onSkip,
    required this.arrowDirection,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: arrowDirection == ArrowDirection.topRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Arrow
          if (arrowDirection == ArrowDirection.topRight ||
              arrowDirection == ArrowDirection.topLeft)
            _buildArrow(),

          // Tooltip content
          Container(
            padding: const EdgeInsets.all(16),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message
                Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom row: Step indicator & Next button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Step indicator
                    Text(
                      '$currentStep of $totalSteps',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),

                    // Next button
                    GestureDetector(
                      onTap: onNext,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
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

          // Arrow for bottom directions
          if (arrowDirection == ArrowDirection.bottomRight ||
              arrowDirection == ArrowDirection.bottomLeft)
            Transform.rotate(
              angle: math.pi,
              child: _buildArrow(),
            ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Padding(
      padding: EdgeInsets.only(
        right: arrowDirection == ArrowDirection.topRight ||
                arrowDirection == ArrowDirection.bottomRight
            ? 30
            : 0,
        left: arrowDirection == ArrowDirection.topLeft ||
                arrowDirection == ArrowDirection.bottomLeft
            ? 30
            : 0,
      ),
      child: CustomPaint(
        size: const Size(20, 10),
        painter: _ArrowPainter(),
      ),
    );
  }
}

// Arrow painter
class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Shadow
    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 4, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Tutorial Step Model
class TutorialStep {
  final String message;
  final Rect? targetRect; // Area to highlight (spotlight)
  final Offset tooltipPosition; // Position of tooltip
  final ArrowDirection arrowDirection;
  final double spotlightBorderRadius;
  final double tooltipWidth;

  TutorialStep({
    required this.message,
    this.targetRect,
    required this.tooltipPosition,
    this.arrowDirection = ArrowDirection.topRight,
    this.spotlightBorderRadius = 16.0,
    this.tooltipWidth = 280,
  });
}

enum ArrowDirection {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
