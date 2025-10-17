import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterNamaPage extends StatefulWidget {
  const RegisterNamaPage({super.key});

  @override
  State<RegisterNamaPage> createState() => _RegisterNamaPageState();
}

class _RegisterNamaPageState extends State<RegisterNamaPage> {
  final TextEditingController _namaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth - 48;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ====================== BAGIAN ATAS (ISI FORM) ======================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tombol kembali
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black87,
                        size: 22,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Judul
                  const Text(
                    'Yuk, mulai isi profilmu!\nPertama, siapa nama kamu?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subjudul
                  const Text(
                    'Nama ini akan ditampilkan pada profil kamu di Jatidiri.App',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Label input
                  const Text(
                    'Nama',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Input nama
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama kamu',
                      hintStyle: const TextStyle(color: Colors.black38),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Color(0xFF6464FA),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),

          // ====================== TOMBOL SELANJUTNYA ======================
          AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic, // 💫 lebih halus dari easeOut
            padding: EdgeInsets.only(
              bottom: keyboardHeight > 0
                  ? max(keyboardHeight - 200, 12) // naik halus di atas keyboard
                  : 40, // posisi normal
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: buttonWidth,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x266464FA),
                        offset: Offset(0, 8),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_namaController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Nama tidak boleh kosong!',
                              style: TextStyle(fontFamily: 'Inter'),
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        // ✅ Navigasi ke halaman RegisterTempatLahir
                        context.push('/register_tempat_lahir');
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    child: const Text(
                      'Selanjutnya',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
