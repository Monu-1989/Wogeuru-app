
import 'package:flutter/material.dart';

/// WOGEURU Official Theme Colors & Styles
class AppColors {
  // Brand palette
  static const Color primaryMaroon = Color(0xFF800000); // deep maroon
  static const Color lightGoldCream = Color(0xFFFFF8DC); // button text
  static const Color gold = Color(0xFFFFD700); // highlights / logo bg
  static const Color creamBackground = Color(0xFFFFF8E7); // app bg
  static const Color grayText = Color(0xFF808080); // secondary text
  static const Color white = Colors.white;

  // Status indicators (allowed exceptions)
  static const Color verifiedGreen = Colors.green; // 🟢 Fully Verified
  static const Color basicOrange = Colors.orange;  // 🟠 Basic Verified
}

class AppButtonStyles {
  // Primary emotional button
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryMaroon,
    foregroundColor: AppColors.lightGoldCream, // text/icon color
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  // Secondary (filters, small actions)
  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.creamBackground,
    foregroundColor: AppColors.grayText,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );
}
