import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterStatusPage extends StatefulWidget {
  const RegisterStatusPage({super.key});

  @override
  State<RegisterStatusPage> createState() => _RegisterStatusPageState();
}

class _RegisterStatusPageState extends State<RegisterStatusPage> {
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth - 48;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      body: SafeArea(
        child: Padding(
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
                  onPressed: () => context.go('/welcome'),
                ),
              ),

              const SizedBox(height: 8),

              // Judul
              const Text(
                'Status kamu yang mana, nih?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),

              // Subjudul
              const Text(
                'Dengan info ini, kami bisa lebih mengenal kamu.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 32),

              // Pilihan Pelajar
              _buildOptionCard(
                title: 'Pelajar',
                imagePath: 'assets/images/pelajar.png',
                value: 'pelajar',
              ),
              const SizedBox(height: 16),

              // Pilihan Non Pelajar
              _buildOptionCard(
                title: 'Non Pelajar',
                imagePath: 'assets/images/nonpelajar.png',
                value: 'nonpelajar',
              ),

              const Spacer(),

              // Tombol Selanjutnya
              Center(
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
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x266464FA),
                        offset: const Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: selectedStatus == null
                        ? null
                        : () {
                            context.go('/register_email');
                          },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          const Color(0xFFBEBEFB).withOpacity(0.4),
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

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String imagePath,
    required String value,
  }) {
    final isSelected = selectedStatus == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6464FA)
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0x1A6464FA),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.black : Colors.black87,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color:
                  isSelected ? const Color(0xFF6464FA) : Colors.grey.shade400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
