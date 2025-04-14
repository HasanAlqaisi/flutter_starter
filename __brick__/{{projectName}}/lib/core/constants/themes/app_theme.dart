import 'package:{{projectName}}/core/constants/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 56,
        letterSpacing: -1,
        // height: 58.8,
        color: AppColors.text,
      ),
      displayMedium: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 40,
        letterSpacing: -1,
        // height: 46,
        color: AppColors.text,
      ),
      displaySmall: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        letterSpacing: -1,
        // height: 42,
        color: AppColors.text,
      ),
      headlineLarge: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        letterSpacing: -0.5,
        // height: 32,
        color: AppColors.text,
      ),
      headlineMedium: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        letterSpacing: -0.5,
        // height: 26,
        color: AppColors.text,
      ),
      bodyLarge: GoogleFonts.tajawal(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: -0.5,
        // height: 26,
        color: AppColors.text,
      ),
      bodyMedium: GoogleFonts.tajawal(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        // height: 21,
        color: AppColors.text,
      ),
      bodySmall: GoogleFonts.tajawal(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        // height: 18,
        color: AppColors.textSmall,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: -0.5,
          // height: 26,
          color: AppColors.text,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 80,
      titleTextStyle: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        letterSpacing: -0.5,
        // height: 26,
        color: AppColors.text,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      horizontalTitleGap: 0,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
