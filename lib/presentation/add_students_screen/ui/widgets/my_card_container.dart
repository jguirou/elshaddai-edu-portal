import 'package:flutter/material.dart';

class MyCardContainer extends StatelessWidget {
  final List<Widget> children;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;

  const MyCardContainer({
    super.key,
    required this.children,
    this.leftPadding = 20.0,
    this.rightPadding = 20.0,
    this.topPadding = 20.0,
    this.bottomPadding = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding,
            right: rightPadding,
            top: topPadding,
            bottom: bottomPadding),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
