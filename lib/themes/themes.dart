// themes/theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: Colors.blue,
      //accentColor: Colors.green,
      scaffoldBackgroundColor: Colors.white, // Couleur par défaut du bouton
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue, // Couleur par défaut du bouton
        textTheme: ButtonTextTheme.primary, // Style du texte du bouton
      ),
      // Autres propriétés du thème clair
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey[900], // Couleur par défaut du bouton
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.indigo, // Couleur par défaut du bouton
        textTheme: ButtonTextTheme.primary, // Style du texte du bouton
      ),
      // Autres propriétés du thème sombre
    );
  }
}
