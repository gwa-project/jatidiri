import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateConfirmPage extends StatelessWidget {
  const UpdateConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final frameWidth = screenWidth > 400 ? 362.0 : screenWidth - 32;
    final horizontalMargin = (screenWidth - frameWidth) / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // ======= Ilustrasi =======
              Image.asset(
                'assets/images/forgotpass2.png',
                width: frameWidth * 0.8,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // ======= Judul =======
              const Text(
                "Sandi berhasil diperbarui.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // ======= Deskripsi =======
              const Text(
                "Sekarang kamu dapat\nmenggunakannya untuk masuk.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 3),

              // ======= Tombol Masuk =======
              GestureDetector(
                onTap: () {
                  context.go('/login');
                },
                child: Container(
                  width: frameWidth,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: const [
                      // Shadow 1: Subtle black shadow untuk depth
                      BoxShadow(
                        color: Color(0x16000000), // #000000 dengan 8.71% opacity
                        blurRadius: 5.57,
                        offset: Offset(0, 3.44),
                        spreadRadius: 0,
                      ),
                      // Shadow 2: Purple glow effect
                      BoxShadow(
                        color: Color(0x266464FA), // #6464FA dengan 15% opacity
                        blurRadius: 37.08,
                        offset: Offset(0, 22.91),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}