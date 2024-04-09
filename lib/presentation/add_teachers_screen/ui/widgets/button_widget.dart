import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function onTapped;
  final String title;
  final Color? buttonColor;

  const ButtonWidget({
    super.key,
    required this.onTapped,
    required this.title,
    this.buttonColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
        //_signIn();
        /// reload page
      },
      child: Container(
        width: 99,
        height: 45,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
