import 'package:flutter/material.dart';
import '../theme/wogeuru_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.gold, width: 0.6),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to WOGEURU'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryMaroon,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Email
              const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'you@example.com',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder.copyWith(
                    borderSide: const BorderSide(color: AppColors.primaryMaroon, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              const Text('Password', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '••••••••',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder.copyWith(
                    borderSide: const BorderSide(color: AppColors.primaryMaroon, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Primary Emotional Button
              ElevatedButton(
                onPressed: () {},
                style: AppButtonStyles.primaryButton,
                child: const Text('Yes, let me in 💝'),
              ),
              const SizedBox(height: 12),

              // Secondary Button
              ElevatedButton(
                onPressed: () {},
                style: AppButtonStyles.secondaryButton,
                child: const Text('Create account'),
              ),

              const Spacer(),

              // Footer / brand line
              const Text(
                'Luxury. Emotion. Trust.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryMaroon,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
