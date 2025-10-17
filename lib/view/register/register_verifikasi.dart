import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class RegisterVerifikasiPage extends StatefulWidget {
  final String email;

  const RegisterVerifikasiPage({super.key, required this.email});

  @override
  State<RegisterVerifikasiPage> createState() => _RegisterVerifikasiPageState();
}

class _RegisterVerifikasiPageState extends State<RegisterVerifikasiPage> {
  final TextEditingController _pinController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth - 48;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ======================== KONTEN UTAMA ========================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tombol back
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.black87, size: 22),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Judul
                  const Text(
                    'Kami cuma perlu pastikan ini memang kamu.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Deskripsi email
                  Text(
                    'Kode verifikasi sudah kami kirim ke\n${widget.email}. Yuk, masukkan kodenya di bawah.',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Label Code
                  const Text(
                    'Code',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Input OTP
                  Center(
                    child: Pinput(
                      controller: _pinController,
                      length: 5,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF6464FA),
                            width: 1.5,
                          ),
                        ),
                      ),
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 22,
                            height: 2,
                            color: const Color(0xFF6464FA),
                          ),
                        ],
                      ),
                      keyboardType: TextInputType.number,
                      onCompleted: (value) {
                        debugPrint("Kode dimasukkan: $value");
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Timer / kirim ulang
                  Center(
                    child: _canResend
                        ? TextButton(
                            onPressed: () {
                              debugPrint("Kirim ulang kode ke ${widget.email}");
                              _startTimer();
                            },
                            child: const Text(
                              "Kirim ulang kode",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6464FA),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : Text(
                            "The code should arrive $_secondsRemaining. You might need to check your junk folder.",
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),

          // ======================== BAGIAN BAWAH (BUTTON) ========================
          AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? max(MediaQuery.of(context).viewInsets.bottom - 320, 12)
                  : 40,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol Verifikasi
                    Container(
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
                        onPressed: () async {
                          if (_pinController.text == "55555") {
                            // Ganti ke pushReplacement untuk refresh halaman saat kembali
                            await context.push('/register_nama');

                            // 🧹 Reset field & timer ketika kembali ke halaman ini
                            if (mounted) {
                              setState(() {
                                _pinController.clear();
                                _startTimer();
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Kode salah, coba lagi")),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        child: const Text(
                          'Verifikasi',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tombol Buka Gmail
                    Container(
                      width: buttonWidth,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFF6464FA),
                          width: 1.5,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // TODO: Tambahkan intent buka Gmail
                        },
                        child: const Text(
                          'Buka Gmail',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF6464FA),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
