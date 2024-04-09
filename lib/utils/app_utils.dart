import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  static void showSnackBar(BuildContext context, String message) {
    // Implement a function to show a SnackBar
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getActualSchoolYear() {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Determine the start and end months of the school year
    int startMonth = 9; // September
    int endMonth = 8;   // August

    // Determine the start year of the school year
    int startYear = currentDate.month >= startMonth ? currentDate.year : currentDate.year - 1;

    // Determine the end year of the school year
    int endYear = currentDate.month <= endMonth ? currentDate.year : currentDate.year + 1;

    // Construct the school year string
    String schoolYear = '$startYear-$endYear';
    print("fdjkjfkjgkfjgj: $schoolYear");

    return schoolYear;
  }

// Other utility functions...
}
