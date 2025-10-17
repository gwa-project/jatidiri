import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import untuk navigasi GoRouter
import 'package:flutter/scheduler.dart'; // Tambahkan ini untuk addPostFrameCallback (safety navigasi)

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Jeda antar step
    const duration = Duration(seconds: 1);

    for (int i = 0; i < 4; i++) {
      await Future.delayed(duration);
      if (mounted) {
        setState(() {
          _currentStep = i + 1; // Mulai dari step 1 (0 adalah inisial)
        });
      }
    }

    // Navigasi ke onboarding setelah sequence selesai – dengan safety check
    if (mounted) {
      // Delay navigasi hingga frame selesai (hindari "No GoRouter found" error)
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/onboarding'); // Navigasi ke Onboarding via GoRouter
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        child: _buildStep(_currentStep),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      // Step 1: Layar putih kosong
      case 0:
        return Container(
          key: const ValueKey(0),
          color: Colors.white,
        );

      // Step 2: Layar biru (#6464FA) + logo putih
      case 1:
        return Container(
          key: const ValueKey(1),
          color: const Color(0xFF6464FA),
          child: Center(
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), // Ubah logo jadi putih (dari ungu asli)
              child: Image.asset(
                'assets/images/logojatidiri1.png',
                width: 160,
                height: 160, // Tambahkan height untuk proporsi yang lebih baik
              ),
            ),
          ),
        );

      // Step 3: Background putih + logo biru (#6464FA) – centered di tengah
      case 2:
        return Container(
          key: const ValueKey(2),
          color: Colors.white,
          child: Center(
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(Color(0xFF6464FA), BlendMode.srcIn), // Ubah logo jadi biru #6464FA
              child: Image.asset(
                'assets/images/logojatidiri1.png',
                width: 160,
                height: 160,
              ),
            ),
          ),
        );

      // Step 4: Logo biru (posisi sama seperti step 3) + teks "Jatidiri.App" di paling bawah tengah
      case 3:
        return Container(
          key: const ValueKey(3),
          color: Colors.white,
          child: Stack(
            children: [
              // Logo biru di posisi tengah (sama seperti step 3)
              Center(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Color(0xFF6464FA), BlendMode.srcIn),
                  child: Image.asset(
                    'assets/images/logojatidiri1.png',
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
              // Teks di paling bawah tengah (centered horizontally, dekat bottom)
              Positioned(
                bottom: 100, // Jarak dari bottom layar (sesuaikan: 80-120 px tergantung device)
                left: 0,
                right: 0,
                child: const Center(
                  child: Text(
                    "Jatidiri.App",
                    style: TextStyle(
                      fontFamily: "Roboto", // Pastikan font Roboto ditambahkan di pubspec.yaml
                      fontWeight: FontWeight.w500, // Medium (weight 500)
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      height: 1.5, // line-height: 30px (30/20 = 1.5)
                      letterSpacing: 0,
                      color: Color(0xFF6464FA), // Warna biru untuk konsistensi
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        return Container(color: Colors.white, key: const ValueKey('default'));
    }
  }
}