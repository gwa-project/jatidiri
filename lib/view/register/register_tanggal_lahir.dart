import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrasiTanggalLahir extends StatefulWidget {
  const RegistrasiTanggalLahir({Key? key}) : super(key: key);

  @override
  _RegistrasiTanggalLahirState createState() => _RegistrasiTanggalLahirState();
}

class _RegistrasiTanggalLahirState extends State<RegistrasiTanggalLahir> {
  DateTime selectedDate = DateTime(1995, 2, 18);

  void _onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
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
              // Tombol Back
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 22),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 20),

              // Judul Utama
              const Text(
                'Senang bertemu denganmu, Alif.\nKapan ulang tahunmu?',
                style: TextStyle(
                  fontSize: 24, // sedikit lebih besar agar konsisten
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Ini akan membantu kami menampilkan usiamu.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // Picker Tanggal Lahir
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    minimumYear: 1990,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: _onDateChanged,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Selanjutnya (sama persis seperti di register_tempat_lahir)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                    shadowColor: const Color(0xFF8C88FF).withOpacity(0.5),
                  ),
                  onPressed: () {
                    context.push('/register_gender');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Tanggal lahir: ${selectedDate.day} '
                          '${_monthName(selectedDate.month)} '
                          '${selectedDate.year}',
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8C88FF), Color(0xFF6E7BFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Selanjutnya',
                        style: TextStyle(
                          fontSize: 18, // disamakan seperti di register_tempat_lahir
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
