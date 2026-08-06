import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors
  static const primary = Color(0xFF0D47A1);
  static const secondary = Color(0xFFFF6F00);
  static const tertiary = Color(0xFF00B8D4);
  static const alternate = Color(0xFFE5E7EB);

  // Feature Colors (Branding)
  static const islamicGreen = Color(0xFF06402B);
  static const islamicGold = Color(0xFFD4AF37);

  // Surface Colors
  static const background = Color(0xFFF5F7FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFE8EAF6);

  // Text Colors
  static const textPrimary = Color(0xFF1A1C1E);
  static const textSecondary = Color(0xFF5D5F61);

  // Functional Colors
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFF9800);
  static const error = Color(0xFFE53935);
  static const info = Color(0xFF2196F3);

  // On-Colors
  static const onPrimary = Colors.white;
  static const onSecondary = Colors.white;
  static const onSuccess = Colors.white;
  static const onError = Colors.white;
}

class AppSpacing {
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 9999.0;
}

class AppShadows {
  static List<BoxShadow> sm = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> md = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> lg = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.primary, Color(0xFF1565C0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accent = LinearGradient(
    colors: [AppColors.secondary, AppColors.warning],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTypography {
  static TextStyle displayLarge = GoogleFonts.plusJakartaSans(
    fontSize: 57.0,
    fontWeight: FontWeight.bold,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  static TextStyle titleLarge = GoogleFonts.plusJakartaSans(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.plusJakartaSans(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.plusJakartaSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = GoogleFonts.plusJakartaSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textSecondary,
  );
}
