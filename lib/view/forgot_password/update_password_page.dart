import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ========== CUSTOM BUTTON WIDGET ==========
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          gradient: const LinearGradient(
            colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4D6464FA),
              blurRadius: 20,
              offset: Offset(0, 10),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ========== UPDATE PASSWORD PAGE ==========
class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordMatch = false;

  void _checkPasswordMatch() {
    setState(() {
      _passwordMatch = _passwordController.text == _confirmPasswordController.text &&
          _passwordController.text.isNotEmpty;
    });
  }

  bool _validatePassword(String password) {
    // Validasi: 8-15 karakter, minimal 3 huruf dan 1 angka
    if (password.length < 8 || password.length > 15) return false;
    
    int letterCount = password.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    int digitCount = password.replaceAll(RegExp(r'[^0-9]'), '').length;
    
    return letterCount >= 3 && digitCount >= 1;
  }

  void _handleConfirm() {
    if (!_passwordMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password tidak sesuai.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_validatePassword(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password harus 8-15 karakter, minimal 3 huruf dan 1 angka.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Panggil API untuk update password di sini
    // Setelah berhasil, navigate ke halaman konfirmasi
    context.go('/update-confirm');
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final frameWidth = screenWidth > 400 ? 362.0 : screenWidth - 32;
    final horizontalMargin = (screenWidth - frameWidth) / 2;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // ======= AppBar Kustom =======
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                            onPressed: () => context.pop(),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: const Text(
                                "Password Baru",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ======= Deskripsi =======
                    const Text(
                      "Gunakan 8–15 karakter, ya. Wajib ada minimal 3 huruf dan 1 angka. "
                      "Boleh juga pakai simbol seperti @ . & - +.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ======= Field Password Baru =======
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Password Baru",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black26),
                            ),
                          ),
                          onChanged: (_) => _checkPasswordMatch(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ======= Field Konfirmasi Password =======
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Konfirmasi Password",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black26),
                            ),
                          ),
                          onChanged: (_) => _checkPasswordMatch(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ======= Pesan Validasi =======
                    if (_passwordMatch)
                      const Text(
                        "Password Kamu Sesuai !",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),

              // ======= Tombol Konfirmasi dengan CustomButton =======
              Positioned(
                left: 0,
                right: 0,
                bottom: viewInsets > 0 ? viewInsets - 330 : 40,
                child: CustomButton(
                  text: 'Konfirmasi',
                  onTap: _handleConfirm,
                  width: frameWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}