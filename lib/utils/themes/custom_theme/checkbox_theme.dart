import 'package:flutter/material.dart';

class MyCheckBoxTheme {
  MyCheckBoxTheme._();

  static CheckboxThemeData lightCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      return states.contains(MaterialState.selected) ?  Colors.white: Colors.black;
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      return states.contains(MaterialState.selected) ?  Colors.blue: Colors.transparent;
    }),
  );
  static CheckboxThemeData darkCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      return states.contains(MaterialState.selected) ?  Colors.white: Colors.black;
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      return states.contains(MaterialState.selected) ?  Colors.blue: Colors.transparent;
    }),
  );
}