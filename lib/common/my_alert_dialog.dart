import 'package:flutter/material.dart';

import '../utils/constants/texts.dart';


class MyAlertDialog{



  static errorAlertDialog({required BuildContext context, required title, message = '', }){
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(AppTexts.error),
        content: Text(message),

        icon:  Icon(Icons.warning, color: Colors.red.shade600),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(AppTexts.ok),
          ),
        ],
      );
    },);

  }
}