import 'package:flutter/material.dart';
import 'theme/wogeuru_theme.dart';
import 'screens/splash_screen.dart';

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
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.creamBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryMaroon,
          foregroundColor: AppColors.lightGoldCream,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppButtonStyles.primaryButton,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryMaroon,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
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

/// Fade transition screen from splash to login
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
        MaterialPageRoute(builder: (_) => const SplashScreen()),
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
