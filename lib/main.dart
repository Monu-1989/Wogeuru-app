
import 'package:flutter/material.dart';
import 'theme/wogeuru_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const WogeuruApp());
}

class WogeuruApp extends StatelessWidget {
  const WogeuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WOGEURU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.creamBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primaryMaroon,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppButtonStyles.primaryButton,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(
            color: AppColors.primaryMaroon,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const BrandSplashToLogin(),
    );
  }
}

/// Small handoff screen after native splash fades
class BrandSplashToLogin extends StatefulWidget {
  const BrandSplashToLogin({super.key});

  @override
  State<BrandSplashToLogin> createState() => _BrandSplashToLoginState();
}

class _BrandSplashToLoginState extends State<BrandSplashToLogin> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.creamBackground,
      body: Center(
        child: Text(
          'WOGEURU',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryMaroon,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
