import 'package:go_router/go_router.dart';
import 'package:jatidiri/homescreen/homescreen.dart';
import 'package:jatidiri/view/forgot_password/check_email_page.dart';
import 'package:jatidiri/view/forgot_password/forgot_password.dart';
import 'package:jatidiri/view/forgot_password/update_confirm.dart';
import 'package:jatidiri/view/forgot_password/update_password_page.dart';
import 'package:jatidiri/view/login/login.dart';
import 'package:jatidiri/view/onboarding.dart';
import 'package:jatidiri/view/register/register.dart';
import 'package:jatidiri/view/register/register_email.dart';
import 'package:jatidiri/view/register/register_gender.dart';
import 'package:jatidiri/view/register/register_tanggal_lahir.dart';
import 'package:jatidiri/view/register/register_tempat_lahir.dart';
import 'package:jatidiri/view/register/register_verifikasi.dart';
import 'package:jatidiri/view/register/register_nama.dart'; // <--- tambahkan ini
import 'package:jatidiri/view/splashscreen/splashscreen1.dart';
import 'package:jatidiri/view/splashscreen/splashscreen2.dart';
import 'package:jatidiri/view/survey/survey.dart';
import 'package:jatidiri/view/welcome.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen1(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const Welcome(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterStatusPage(),
    ),
    GoRoute(
      path: '/register_email',
      builder: (context, state) => const RegisterEmailPage(),
    ),
    GoRoute(
      path: '/verifikasi',
      builder: (context, state) {
        final email = state.extra as String;
        return RegisterVerifikasiPage(email: email);
      },
    ),
    GoRoute(
      path: '/register_tempat_lahir',
      builder: (context, state) => const RegisterTempatLahir(),
    ),
    // 🆕 Route baru untuk halaman isi nama
    GoRoute(
      path: '/register_nama',
      builder: (context, state) => const RegisterNamaPage(),
    ),
    GoRoute(
      path: '/register_tanggal_lahir',
      builder: (context, state) => const RegistrasiTanggalLahir(),
    ),
    GoRoute(
  path: '/register_gender',
  builder: (context, state) => const RegisterGenderPage(),
),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(), // Route untuk halaman login
    ),
    GoRoute(
  path: '/forgot-password',
  builder: (context, state) => const ForgotPasswordPage(),
),
    GoRoute(
  path: '/check-email',
  builder: (context, state) {
    final email = state.extra as String? ?? 'alamatmu';
    return CheckEmailPage(email: email);
  },
),
GoRoute(
  path: '/update-password',
  builder: (context, state) => const UpdatePasswordPage(),
),
GoRoute(
  path: '/update-confirm',
  builder: (context, state) => const UpdateConfirmPage(),
),
GoRoute(
  path: '/survey',
  builder: (context, state) => const SurveyPage(),
),
GoRoute(
  path: '/splashscreen2',
  builder: (context, state) => const SplashScreen2(),
),
GoRoute(
        path: '/homescreen',
        builder: (context, state) => const HomeScreen(),
      ),

  ],
);
