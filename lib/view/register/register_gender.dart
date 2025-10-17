import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterGenderPage extends StatefulWidget {
  const RegisterGenderPage({Key? key}) : super(key: key);

  @override
  _RegisterGenderPageState createState() => _RegisterGenderPageState();
}

class _RegisterGenderPageState extends State<RegisterGenderPage> {
  String? selectedGender;

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });

    // Navigasi ke halaman berikutnya (misal: tanggal lahir)
    Future.delayed(const Duration(milliseconds: 300), () {
      context.push('/register_tanggal_lahir');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol back
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () {
                  context.pop();
                },
              ),
              const SizedBox(height: 20),

              // Judul
              const Text(
                'Pilih Jenis Kelamin Kamu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Pilih jenis kelamin yang paling menggambarkanmu.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 50),

              // Tombol Laki-laki
              _buildGenderButton(
                label: 'Laki - Laki',
                isSelected: selectedGender == 'Laki - Laki',
                onTap: () => _selectGender('Laki - Laki'),
              ),
              const SizedBox(height: 20),

              // Tombol Perempuan
              _buildGenderButton(
                label: 'Perempuan',
                isSelected: selectedGender == 'Perempuan',
                onTap: () => _selectGender('Perempuan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF8C88FF), Color(0xFF6E7BFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: isSelected
              ? null
              : Border.all(
                  color: const Color(0xFF8C88FF),
                  width: 1.5,
                ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6E7BFF),
          ),
        ),
      ),
    );
  }
}
