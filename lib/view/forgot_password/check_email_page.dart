import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckEmailPage extends StatelessWidget {
  final String email;

  const CheckEmailPage({super.key, required this.email});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              // === Gambar ilustrasi (ukuran presisi) ===
              Image.asset(
                'assets/images/forgotpass1.png',
                width: 440,
                height: 437,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 0),

              // === Judul ===
              const Text(
                "Cek Email Kamu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // === Deskripsi ===
              Text(
                "Tautan reset kata sandi sudah kami kirim ke $email. "
                "Kalau belum sampai, coba cek di folder spam, ya, "
                "atau minta tautan baru.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // === Tombol Masuk ===
              GestureDetector(
                onTap: () => context.go('/update-password'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x266464FA),
                        blurRadius: 37,
                        offset: Offset(0, 8),
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
