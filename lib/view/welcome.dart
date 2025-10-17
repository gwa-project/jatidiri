import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    // Update: Path video MP4 iPhone spin up fix
    _controller = VideoPlayerController.asset('assets/videos/iphonespinup.mp4');
    await _controller.initialize();
    _controller.setLooping(true);
    await _controller.play();
    if (mounted) {
      setState(() {
        _isVideoInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToRegister(BuildContext context) {
    context.go('/register');
  }

  void _navigateToLogin(BuildContext context) {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = math.min(screenWidth - 48, 340.0);
    final horizontalMargin = math.max(0.0, (screenWidth - buttonWidth) / 2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 40), // jarak atas teks
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF6464FA), Color(0xFF3B3B94)],
                  ).createShader(bounds),
                  child: const Text(
                    'Selamat Datang di Jatidiri.App',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kenali Dirimu Raih Masa\nDepan Gemilang',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // video iPhone di tengah (update path MP4)
                // video iPhone di tengah (tanpa fallback gambar)
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 250,
                      height: 460,
                      child: _isVideoInitialized
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: VideoPlayer(_controller), // Video MP4 iphonespinup.mp4
                            )
                          : const SizedBox.shrink(), // Tidak tampilkan apa-apa sebelum video siap
                    ),
                  ),
                ),


                const SizedBox(height: 40),

                // tombol daftar dan masuk
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                  child: Column(
                    children: [
                      Container(
                        width: buttonWidth,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () => _navigateToRegister(context),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: buttonWidth,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: Colors.white,
                          border: Border.all(color: Color(0xFF9898FC), width: 1.5),
                        ),
                        child: TextButton(
                          onPressed: () => _navigateToLogin(context),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF6464FA),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}