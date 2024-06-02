import 'package:flutter/material.dart';
class AppColors{
  AppColors._();

  // App basic colors
  static const primary = Color(0xFF0000ff);
  static const secondary = Color(0xFFFFE24B);
  static const accent = Color(0xFFb0c7ff);

  static const hoverColor = Color(0xFFBBDEFB);

  // Gradient Colors
  static  const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xFFFF9A9E),
        Color(0xFFFAD0C4),
        Color(0xFFFAD0C4)
      ]
  );


  // Text colors
  static const textPrimary = Color(0xFF333333);
  static const textSecondary = Color(0xFF6c757D);
  static const textWhite = Colors.white;



  // Background colors
  static const light = Color(0xFFF6F6F6);
  static const dark = Color(0xFF272727);
  static const primaryBackground = Color(0xFFF3F5FF);




  // Background Containers colors
  static const lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.white.withOpacity(0.1);


  // Button colors
  static const buttonPrimary = Color(0xFF4b68ff);
  static const buttonSecondary = Color(0xFF6C757D);
  static const buttonDisabled = Color(0xFFC4C4C4);


  // Border colors
  static const borderPrimary = Color(0xFFD9D9D9);
  static const borderSecondary = Color(0xFFE6E6E6);


  // Error or validations colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);


  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

}