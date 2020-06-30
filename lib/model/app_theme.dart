import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      // button text
      subtitle2: GoogleFonts.poppinsTextTheme().subtitle2.copyWith(
            color: Colors.white,
          ),
      // app bar text
      headline4: GoogleFonts.poppinsTextTheme().headline4.copyWith(
            color: Colors.white,
          ),
    ),
  );
}
