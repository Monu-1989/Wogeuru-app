// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:wogeuru/screens/login_screen.dart';
import 'package:wogeuru/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/icons/wogeuru_logo.png',
            fit: BoxFit.cover,
          ),

          // Fade-in logo
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/icons/wogeuru_logo.png',
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
