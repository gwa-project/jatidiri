// lib/homescreen/homescreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jatidiri/widget/home_tutorial_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _sliderController = PageController(
    initialPage: 0,
    viewportFraction: 0.88,
  );

  int _currentNavIndex = 0;
  final GlobalKey _profileCardKey = GlobalKey();
  final GlobalKey _mainCardKey = GlobalKey();
  final GlobalKey _bottomNavKey = GlobalKey();
  bool _tutorialShown = false;

  @override
  void initState() {
    super.initState();
    // Auto-show tutorial setiap kali buka halaman
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _showHomeTutorial();
    });
  }

  void _showHomeTutorial() {
    if (_tutorialShown) {
      return;
    }

    final Rect? profileRect = _getWidgetBounds(_profileCardKey);
    final Rect? mainCardRect = _getWidgetBounds(_mainCardKey);
    final Rect? bottomNavRect = _getWidgetBounds(_bottomNavKey);

    if (profileRect == null || mainCardRect == null || bottomNavRect == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _showHomeTutorial();
      });
      return;
    }

    _tutorialShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => HomeTutorialOverlay(
        profileRect: profileRect,
        mainCardRect: mainCardRect,
        bottomNavRect: bottomNavRect,
        onComplete: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildMainCard(),
              const SizedBox(height: 30),
              _buildSectionTitle(),
              const SizedBox(height: 16),
              _buildPackageSlider(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavKey,
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6464FA),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_outlined),
            activeIcon: Icon(Icons.psychology),
            label: 'HalloPsy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              key: _profileCardKey,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/profilhome.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            Text(
                              'Good Morning,',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6C6C6C),
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '\u{1F44B}',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Alif Noor Rachman',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.notifications_none_rounded,
                size: 24,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      key: _mainCardKey,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B8CFF), Color(0xFF9BA8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row untuk teks (seperti sebelumnya)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Siap Cari Tahu Siapa Dirimu?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Yuk, ikuti tes psikologi dan temukan potensimu.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Jarak sebelum gambar baru

          // Tambahkan gambar baru (survei.png) di bawah, dekat garis border
          // Saya taruh di bawah gambar lama untuk menghindari overlap, tapi Anda bisa sesuaikan
          Align(
            alignment: Alignment.bottomRight, // Dekat garis border kanan bawah
            child: SizedBox(
              width: 110, // Ukuran yang Anda tentukan
              height: 110,
              child: Image.asset(
                'assets/images/survei.png',
                fit: BoxFit
                    .contain, // Perbaiki dari 'fit: ,' menjadi 'fit: BoxFit.contain'
                errorBuilder: (context, error, stackTrace) {
                  return _buildCharacterPlaceholder();
                },
              ),
            ),
          ),

          const SizedBox(height: 16), // Jarak sebelum tombol
          ElevatedButton(
            onPressed: () {
              print('Coba Sekarang clicked');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF7B8CFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 12,
              ),
              elevation: 0,
            ),
            child: const Text(
              'Coba Sekarang',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: CustomPaint(
        painter: CharacterIllustrationPainter(),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Paket Jatidiri.App',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildPackageSlider() {
    return SizedBox(
      height: 450,
      child: PageView(
        controller: _sliderController,
        padEnds: false,
        children: [
          _buildPackageCard(
            color: const Color(0xFFE89B6D),
            title: 'Jatidiri Universitas',
            description:
                'Membantu menciptakan ekosistem pendidikan yang menguatkan mental, karakter, dan potensi mahasiswa.',
            image: 'assets/images/cardunivhome.png',
          ),
          // Temporarily commented out - images not available yet
          // _buildPackageCard(
          //   color: const Color(0xFF6BC5D9),
          //   title: 'Jatidiri Profesional',
          //   description: 'Membantu meningkatkan potensi diri dalam karir dan pekerjaan profesional.',
          //   image: 'assets/images/card_professional.png',
          // ),
          // _buildPackageCard(
          //   color: const Color(0xFF9B8CDB),
          //   title: 'Jatidiri Personal',
          //   description: 'Mengenal diri lebih dalam untuk pengembangan personal yang optimal.',
          //   image: 'assets/images/card_personal.png',
          // ),
        ],
      ),
    );
  }

  Widget _buildPackageCard({
    Key? key,
    required Color color,
    required String title,
    required String description,
    required String image,
  }) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Image section - LEBIH BESAR
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _buildCardCharacterPlaceholder();
                },
              ),
            ),
          ),
          // Content section
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              print('Tes Sekarang clicked: $title');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7B8CFF),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Tes Sekarang',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B8CFF),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            print('Bookmark clicked: $title');
                          },
                          icon: const Icon(
                            Icons.bookmark,
                            color: Colors.white,
                            size: 22,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardCharacterPlaceholder() {
    return Container(
      child: const Center(
        child: Icon(
          Icons.person_outline,
          size: 100,
          color: Colors.white54,
        ),
      ),
    );
  }

  Rect? _getWidgetBounds(GlobalKey key) {
    final BuildContext? targetContext = key.currentContext;
    if (targetContext == null) {
      return null;
    }

    final RenderObject? renderObject = targetContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return null;
    }

    final Offset offset = renderObject.localToGlobal(Offset.zero);
    return offset & renderObject.size;
  }

  @override
  void dispose() {
    _sliderController.dispose();
    super.dispose();
  }
}

// Custom painter for character illustration
class CharacterIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Head
    canvas.drawCircle(
      Offset(size.width * 0.6, size.height * 0.25),
      size.width * 0.15,
      paint,
    );

    // Body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.5,
        size.height * 0.35,
        size.width * 0.25,
        size.height * 0.3,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(bodyRect, paint);

    // Left arm (pointing)
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.4),
      size.width * 0.08,
      paint,
    );

    // Right arm
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.5),
      size.width * 0.08,
      paint,
    );

    // Legs
    canvas.drawCircle(
      Offset(size.width * 0.55, size.height * 0.75),
      size.width * 0.06,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.75),
      size.width * 0.06,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
