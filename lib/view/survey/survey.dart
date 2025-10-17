import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  // Menyimpan jawaban survey
  final Map<int, String> _answers = {};

  // Data survey untuk setiap halaman
  final List<Map<String, dynamic>> _surveyData = [
    {
      'question': 'Apa tujuan utamamu\nsaat ini?',
      'options': [
        {'text': 'Tumbuh secara profesional', 'icon': Icons.trending_up_rounded},
        {'text': 'Menjaga kesehatan mental', 'icon': Icons.favorite_border_rounded},
        {'text': 'Berprestasi di sekolah', 'icon': Icons.school_outlined},
        {'text': 'Mendampingi siswa belajar', 'icon': Icons.people_outline_rounded},
        {'text': 'Membantu anak belajar', 'icon': Icons.child_care_outlined},
      ],
    },
    {
      'question': 'Apa yang paling sering\nkamu rasakan belakangan\nini?',
      'options': [
        {'text': 'Cemas atau\nmudah khawatir', 'icon': Icons.sentiment_dissatisfied_outlined},
        {'text': 'Sering merasa\nlelah tanpa alasan', 'icon': Icons.battery_0_bar_outlined},
        {'text': 'Sulit fokus atau\nsulit tidur', 'icon': Icons.bedtime_outlined},
        {'text': 'Merasa tidak\ntermotivasi', 'icon': Icons.trending_down_rounded},
        {'text': 'Perasaan naik\nturun', 'icon': Icons.show_chart_rounded},
        {'text': 'Saya belum tahu\npasti', 'icon': Icons.help_outline_rounded},
      ],
    },
    {
      'question': 'Cara Kamu Menghadapi\nMasalah Pertanyaan',
      'options': [
        {'text': 'Menyendiri dan berpikir sendiri', 'icon': Icons.person_outline_rounded},
        {'text': 'Curhat ke teman atau keluarga', 'icon': Icons.chat_bubble_outline_rounded},
        {'text': 'Menulis atau membuat jurnal', 'icon': Icons.edit_note_rounded},
        {'text': 'Mengalihkan dengan aktivitas lain', 'icon': Icons.directions_run_rounded},
        {'text': 'Konsultasi dengan profesional', 'icon': Icons.support_agent_rounded},
      ],
    },
    {
      'question': 'Apa yang kamu harapkan\ndari Jatidiri?',
      'options': [
        {'text': 'Bisa konsultasi\nkapan saja', 'icon': Icons.access_time_rounded},
        {'text': 'Rekomendasi\nartikel atau video', 'icon': Icons.article_outlined},
        {'text': 'Dapat gambaran\nkondisi psikologis', 'icon': Icons.psychology_outlined},
        {'text': 'Menemukan arah\nhidup atau karir', 'icon': Icons.explore_outlined},
        {'text': 'Tempat aman\nuntuk cerita', 'icon': Icons.lock_outline_rounded},
        {'text': 'Saya belum yakin,\ningin coba dulu', 'icon': Icons.lightbulb_outline_rounded},
      ],
    },
  ];

  void _nextPage() {
    if (_answers[_currentPage] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih salah satu jawaban terlebih dahulu'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Survey selesai, simpan hasil dan navigate
      _submitSurvey();
    }
  }

  void _submitSurvey() {
    // TODO: Kirim hasil survey ke backend
    print('Survey Results: $_answers');
    
    // Navigate ke splash screen 2
    context.go('/splashscreen2');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Progress Bar & Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.pop();
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  const SizedBox(width: 12),

                  // Progress Bar
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (_currentPage + 1) / _totalPages,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6464FA)),
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // PageView untuk survey slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _totalPages,
                itemBuilder: (context, index) {
                  final data = _surveyData[index];
                  return _SurveySlide(
                    question: data['question'],
                    options: data['options'],
                    selectedOption: _answers[index],
                    onOptionSelected: (option) {
                      setState(() {
                        _answers[index] = option;
                      });
                    },
                    pageIndex: index,
                  );
                },
              ),
            ),

            // Button Selanjutnya
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _CustomButton(
                text: _currentPage == _totalPages - 1 ? 'Selesai' : 'Selanjutnya',
                onTap: _nextPage,
                width: screenWidth - 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter untuk Speech Bubble dengan tail
class _SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8E8FF)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF9898FC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    const radius = 16.0;
    const tailSize = 8.0;

    // Start from top left
    path.moveTo(radius, 0);
    // Top edge
    path.lineTo(size.width - radius, 0);
    // Top right corner
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );
    // Right edge
    path.lineTo(size.width, size.height - radius);
    // Bottom right corner
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: const Radius.circular(radius),
    );
    // Bottom edge
    path.lineTo(radius, size.height);
    // Bottom left corner
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: const Radius.circular(radius),
    );
    // Left edge (dengan tail/ekor)
    path.lineTo(0, radius + tailSize + 10);
    // Tail - ekor mengarah ke kiri
    path.lineTo(-tailSize, radius + 10);
    path.lineTo(0, radius + 5);
    // Continue left edge
    path.lineTo(0, radius);
    // Top left corner
    path.arcToPoint(
      Offset(radius, 0),
      radius: const Radius.circular(radius),
    );

    path.close();

    // Draw filled bubble
    canvas.drawPath(path, paint);
    // Draw border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Widget untuk setiap slide survey
class _SurveySlide extends StatelessWidget {
  final String question;
  final List<Map<String, dynamic>> options;
  final String? selectedOption;
  final Function(String) onOptionSelected;
  final int pageIndex;

  const _SurveySlide({
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isGridLayout = pageIndex == 1 || pageIndex == 3; // Page 2 dan 4 pakai grid

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Avatar & Question Bubble
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar dengan background circle
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Avatar image
                  Image.asset(
                    'assets/images/survei.png',
                    width: 48,
                    height: 48,
                  ),
                ],
              ),
              const SizedBox(width: 12),

              // Question Bubble dengan tail
              Flexible(
                child: CustomPaint(
                  painter: _SpeechBubblePainter(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Options
          if (isGridLayout)
            // Grid Layout (2 columns)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return _OptionCard(
                  text: option['text'],
                  icon: option['icon'],
                  isSelected: selectedOption == option['text'],
                  onTap: () => onOptionSelected(option['text']),
                );
              },
            )
          else
            // List Layout (full width)
            Column(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _OptionListItem(
                    text: option['text'],
                    icon: option['icon'],
                    isSelected: selectedOption == option['text'],
                    onTap: () => onOptionSelected(option['text']),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

// Widget untuk option card (grid layout)
class _OptionCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8E8FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6464FA) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? const Color(0xFF6464FA) : Colors.black54,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF6464FA) : Colors.black87,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk option list item (full width layout)
class _OptionListItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionListItem({
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8E8FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6464FA) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFF6464FA) : Colors.black54,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? const Color(0xFF6464FA) : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Button Widget
class _CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;

  const _CustomButton({
    required this.text,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          gradient: const LinearGradient(
            colors: [Color(0xFF6464FA), Color(0xFF9898FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 5.57,
              offset: const Offset(0, 3.44),
            ),
            BoxShadow(
              color: const Color(0xFF6464FA).withOpacity(0.15),
              blurRadius: 37.08,
              offset: const Offset(0, 22.91),
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