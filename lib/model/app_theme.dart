import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  final textTheme = GoogleFonts.caveatTextTheme();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.caveatTextTheme().copyWith(
      headline4: GoogleFonts.caveatTextTheme().headline4.copyWith(
            color: Colors.white,
          ),
      headline5: GoogleFonts.caveatTextTheme().headline5.copyWith(
            fontWeight: FontWeight.bold,
          ),
      headline6: GoogleFonts.caveatTextTheme().headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}
