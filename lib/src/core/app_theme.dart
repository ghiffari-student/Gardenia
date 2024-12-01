import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF2E7D32), // Deep green
    scaffoldBackgroundColor: Colors.green[50],
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2E7D32),
      primary: const Color(0xFF2E7D32),
      secondary: const Color(0xFF4CAF50),
    ),
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      titleLarge: GoogleFonts.roboto(
        color: Colors.green[900],
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: Colors.green[800],
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF2E7D32),
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
