import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: AppColors.background,

    textTheme: GoogleFonts.poppinsTextTheme(),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
    ),

              cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),

  );
}