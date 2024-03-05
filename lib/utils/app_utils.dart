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

// Other utility functions...
}
