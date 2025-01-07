import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData kLightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)
      )
  );
}