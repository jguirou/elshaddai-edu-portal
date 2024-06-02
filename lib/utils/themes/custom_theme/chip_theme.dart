import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyChipTheme {
  MyChipTheme._();
  
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: AppColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle( color: AppColors.black),
    selectedColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    checkmarkColor: AppColors.white
  );
  static ChipThemeData darkChipThemeData = const ChipThemeData(
      disabledColor: AppColors.grey,
      labelStyle: TextStyle( color: AppColors.white),
      selectedColor: AppColors.primary,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      checkmarkColor: AppColors.white
  );
}