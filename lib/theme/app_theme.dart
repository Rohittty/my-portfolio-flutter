import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color devOpsPrimary = Color(
    0xFF00E5FF,
  ); // Cyan/Teal for DevOps (Cyber)
  static const Color flutterPrimary = Color(
    0xFF2962FF,
  ); // Deep Blue for Flutter (Mobile)
  static const Color darkBackground = Color(0xFF0A0E12); // Slightly bluish dark
  static const Color darkerBackground = Color(0xFF050709);
  static const Color cardSurface = Color(0xFF141C24);
  static const Color neonAccent = Color(
    0xFF00FF9D,
  ); // High viz green for accents

  static const Color textPrimary = Color(0xFFE0E0E0);
  static const Color textSecondary = Color(0xFFA0A0A0);

  // Night Ops Theme (3:33 AM)
  static const Color nightOpsBackground = Color(0xFF000000);
  static const Color nightOpsPrimary = Color(0xFF00FF00); // Hacker Green

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: devOpsPrimary,
      colorScheme: const ColorScheme.dark(
        primary: devOpsPrimary,
        secondary: flutterPrimary,
        surface: cardSurface,

        onSurface: textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        labelLarge: GoogleFonts.jetBrainsMono(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: devOpsPrimary,
        ),
      ),
      iconTheme: const IconThemeData(color: textPrimary),
      // cardTheme: CardTheme(
      //   color: cardSurface,
      //   elevation: 4,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // ),
    );
  }

}
