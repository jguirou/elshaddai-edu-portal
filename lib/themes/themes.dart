import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(

    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      titleTextStyle:  TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    ),
    primaryColor: Colors.blue,



    hintColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
     textTheme: const TextTheme(
       bodyLarge: TextStyle(
         color: Colors.black,
       )
     ),

    // Couleur par défaut du bouton
    buttonTheme: const ButtonThemeData(

      buttonColor: Colors.blue, // Couleur par défaut du bouton
      textTheme: ButtonTextTheme.primary,
      // Style du texte du bouton
    ),
    // Autres propriétés du thème clair
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      titleTextStyle:  TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    ),
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
        )
    ),// Couleur par défaut du bouton
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue, // Couleur par défaut du bouton
      textTheme: ButtonTextTheme.primary, // Style du texte du bouton
    ),
    // Autres propriétés du thème sombre
  );
}
