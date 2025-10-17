import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2>
    with TickerProviderStateMixin {
  late AnimationController _badgeController;
  late AnimationController _textController;
  late Animation<double> _badgeScaleAnimation;
  late Animation<double> _badgeFadeAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Badge animation controller
    _badgeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Badge scale animation (bounce effect)
    _badgeScaleAnimation = CurvedAnimation(
      parent: _badgeController,
      curve: Curves.elasticOut,
    );

    // Badge fade animation
    _badgeFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _badgeController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    // Text fade animation
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _badgeController.forward();
    
    await Future.delayed(const Duration(milliseconds: 400));
    _textController.forward();

    // Navigate to home/dashboard after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/homescreen'); // Ganti dengan route dashboard/home Anda
    }
  }

  @override
  void dispose() {
    _badgeController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Animated Stars Background
            ..._buildStars(),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Badge with checkmark animation
                  FadeTransition(
                    opacity: _badgeFadeAnimation,
                    child: ScaleTransition(
                      scale: _badgeScaleAnimation,
                      child: _buildBadge(),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Welcome Text
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Column(
                      children: [
                        const Text(
                          'Welcome to Jatidiri!',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48),
                          child: Text(
                            'Your account is successfully created.\nStart exploring your true potential now.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
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

  // Build Badge with checkmark
  Widget _buildBadge() {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Serrated badge background
          CustomPaint(
            size: const Size(100, 100),
            painter: _BadgePainter(),
          ),
          // Checkmark icon
          const Icon(
            Icons.check,
            size: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // Build animated stars
  List<Widget> _buildStars() {
    final stars = <Widget>[];
    final positions = [
      {'top': 100.0, 'left': 50.0, 'size': 20.0, 'delay': 0},
      {'top': 150.0, 'right': 80.0, 'size': 16.0, 'delay': 200},
      {'top': 250.0, 'left': 30.0, 'size': 12.0, 'delay': 400},
      {'top': 300.0, 'right': 40.0, 'size': 14.0, 'delay': 100},
      {'top': 450.0, 'left': 60.0, 'size': 18.0, 'delay': 300},
      {'top': 500.0, 'right': 70.0, 'size': 12.0, 'delay': 500},
      {'top': 180.0, 'left': 120.0, 'size': 10.0, 'delay': 150},
      {'top': 350.0, 'right': 120.0, 'size': 10.0, 'delay': 250},
    ];

    for (var pos in positions) {
      stars.add(
        _AnimatedStar(
          top: pos['top'] as double,
          left: pos['left'] as double?,
          right: pos['right'] as double?,
          size: pos['size'] as double,
          delay: pos['delay'] as int,
        ),
      );
    }

    return stars;
  }
}

// Custom Painter for serrated badge
class _BadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6464FA)
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const teeth = 12; // Number of teeth
    const toothDepth = 0.15; // Depth of teeth (15% of radius)

    for (int i = 0; i < teeth; i++) {
      final angle1 = (i * 2 * math.pi / teeth) - math.pi / 2;
      final angle2 = ((i + 0.5) * 2 * math.pi / teeth) - math.pi / 2;

      // Outer point
      final outer = Offset(
        center.dx + radius * math.cos(angle1),
        center.dy + radius * math.sin(angle1),
      );

      // Inner point (tooth valley)
      final inner = Offset(
        center.dx + radius * (1 - toothDepth) * math.cos(angle2),
        center.dy + radius * (1 - toothDepth) * math.sin(angle2),
      );

      if (i == 0) {
        path.moveTo(outer.dx, outer.dy);
      } else {
        path.lineTo(outer.dx, outer.dy);
      }

      path.lineTo(inner.dx, inner.dy);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Animated Star Widget
class _AnimatedStar extends StatefulWidget {
  final double top;
  final double? left;
  final double? right;
  final double size;
  final int delay;

  const _AnimatedStar({
    required this.top,
    this.left,
    this.right,
    required this.size,
    required this.delay,
  });

  @override
  State<_AnimatedStar> createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<_AnimatedStar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      child: FadeTransition(
        opacity: _animation,
        child: ScaleTransition(
          scale: _animation,
          child: Icon(
            Icons.auto_awesome,
            size: widget.size,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}