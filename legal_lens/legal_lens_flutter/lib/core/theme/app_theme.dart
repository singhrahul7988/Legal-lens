import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF1E207A);
  static const Color primaryYellow = Color(0xFFF7B500);
  static const Color background = Color(0xFFF6F7FB);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF101828);
  static const Color textGrey = Color(0xFF667085);
  static const Color border = Color(0xFFE4E7EC);
  static const Color subtleBlue = Color(0xFFE8EDFF);
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFE5484D);
  static const Color warning = Color(0xFFF59E0B);
  static const Color softWarning = Color(0xFFFFF3E0);
  static const Color softError = Color(0xFFFFE9E9);
  static const Color surface = Color(0xFFF9FAFB);
  static const Color secondaryGold = Color(0xFFD97706);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Segoe UI',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        secondary: AppColors.primaryYellow,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      useMaterial3: true,
    );
  }
}
