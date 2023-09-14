import 'package:{{projectName}}/core/constants/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppTheme {
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 56.sp,
        letterSpacing: -1,
        // height: 58.8.h,
        color: AppColors.text,
      ),
      displayMedium: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 40.sp,
        letterSpacing: -1,
        // height: 46.h,
        color: AppColors.text,
      ),
      displaySmall: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 32.sp,
        letterSpacing: -1,
        // height: 42.h,
        color: AppColors.text,
      ),
      headlineLarge: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        letterSpacing: -0.5,
        // height: 32.h,
        color: AppColors.text,
      ),
      headlineMedium: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        letterSpacing: -0.5,
        // height: 26.h,
        color: AppColors.text,
      ),
      bodyLarge: GoogleFonts.tajawal(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        letterSpacing: -0.5,
        // height: 26.h,
        color: AppColors.text,
      ),
      bodyMedium: GoogleFonts.tajawal(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        // height: 21.h,
        color: AppColors.text,
      ),
      bodySmall: GoogleFonts.tajawal(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        // height: 18.h,
        color: AppColors.textSmall,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          letterSpacing: -0.5,
          // height: 26.h,
          color: AppColors.text,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 80.h,
      titleTextStyle: GoogleFonts.tajawal(
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
        letterSpacing: -0.5,
        // height: 26.h,
        color: AppColors.text,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      horizontalTitleGap: 0,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );
}
