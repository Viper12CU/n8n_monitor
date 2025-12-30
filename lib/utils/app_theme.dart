import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales
  static const Color primaryColor = Color(0xFF38e07b);
  static const Color scaffoldBackground = Color(0xFF122017);

  // // Tema claro
  // static ThemeData lightTheme = ThemeData(
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: Colors.deepPurple,
  //     brightness: Brightness.light,
  //   ),
  //   useMaterial3: true,
  //   appBarTheme: const AppBarTheme(
  //     actionsIconTheme: IconThemeData(
  //       color: Colors.white,
  //     ),
  //     backgroundColor: primaryColor,
  //     elevation: 0,
  //     centerTitle: true,
  //     titleTextStyle: TextStyle(
  //       color: Colors.white,
  //       fontSize: 18,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   scaffoldBackgroundColor: scaffoldBackground,
  // );

  // Tema oscuro (opcional para futuro)
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackground,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Color(0xFF9eb7a8)),
    cardTheme: CardThemeData(color: Color(0xFF1c2b22)),
    scaffoldBackgroundColor: scaffoldBackground,
  );
}
