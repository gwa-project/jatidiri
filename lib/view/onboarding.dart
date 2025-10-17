import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  // Data untuk setiap tahap (gambar, judul, deskripsi)
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Temukan Jatidirimu',
      'description': 'Tes cepat dan akurat untuk memahami kepribadian dan pola pikirmu.',
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Berlandaskan Psikologi Ilmiah',
      'description': 'Dapatkan hasil akurat dari tes yang dikembangkan berdasarkan penelitian psikologi teruji.',
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Datamu Aman dan Terlindungi',
      'description': 'Sepenuhnya terenkripsi. Hanya kamu yang bisa mengakses hasilmu.',
    },
    {
      'image': 'assets/images/onboarding4.png',
      'title': 'Siap Menjelajahi Siapa Dirimu?',
      'description': 'Ikuti tes pertamamu dan temukan lebih banyak tentang dirimu.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/welcome');
    }
  }

  void _skipOnboarding() {
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20), // ✅ Turunkan header sedikit
          
          // Header: Logo kiri + Skip kanan
          Container(
            width: screenWidth,
            height: 69,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo kiri
                Image.asset(
                  'assets/images/logojatidiri2.png',
                  width: 73,
                  height: 37,
                ),
                // Skip button
                GestureDetector(
                  onTap: _skipOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Body: PageView untuk slides
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _totalPages,
              itemBuilder: (context, index) {
                final data = _onboardingData[index];
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          // Banner/Image Section
                          Container(
                            width: screenWidth,
                            height: 374,
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(
                              data['image']!,
                              width: 361,
                              height: 342,
                              fit: BoxFit.contain,
                            ),
                          ),
                          
                          // Description Section
                          Container(
                            width: screenWidth,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 361,
                                  child: Column(
                                    children: [
                                      // Judul
                                      Text(
                                        data['title']!,
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          height: 1.5,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      // Deskripsi
                                      Text(
                                        data['description']!,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 1.4,
                                          color: Colors.black54,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80), // Spacer untuk button
                        ],
                      ),
                    ),
                    
                    // ✅ Button Next Circle (Step 1-3)
                    if (index < 3)
                      Positioned(
                        bottom: 40,
                        right: 24,
                        child: _NextCircleButton(
                          onTap: _nextPage,
                          progress: (index + 1) / 3, // Progress berdasarkan step (1/3, 2/3, 3/3)
                        ),
                      ),
                    
                    // ✅ Button Mulai Rectangle (Step 4)
                    if (index == 3)
                      Positioned(
                        bottom: 40,
                        left: 16,
                        right: 16,
                        child: _MulaiButton(onTap: _nextPage),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Widget Custom: Next Circle Button dengan Progress Border (untuk step 1-3)
class _NextCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final double progress; // Progress 0.0 - 1.0

  const _NextCircleButton({
    required this.onTap,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Progress Circle Border
            SizedBox(
              width: 72,
              height: 72,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 5,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6464FA),
                ),
              ),
            ),
            // Inner Circle Button
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  // Shadow 1: Depth
                  BoxShadow(
                    color: const Color(0xFF6464FA).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  // Shadow 2: Glow
                  BoxShadow(
                    color: const Color(0xFF6464FA).withOpacity(0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Widget Custom: Mulai Button (untuk step 4)
class _MulaiButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MulaiButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          gradient: const LinearGradient(
            colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            // Shadow 1: Subtle black shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 5.57,
              offset: const Offset(0, 3.44),
            ),
            // Shadow 2: Purple glow
            BoxShadow(
              color: const Color(0xFF6464FA).withOpacity(0.15),
              blurRadius: 37.08,
              offset: const Offset(0, 22.91),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Mulai',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}