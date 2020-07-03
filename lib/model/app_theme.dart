import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    // SEIHEKI
    primaryColor: NipponColors.nipponColor168,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
      secondary: NipponColors.nipponColor168,
    ),
    highlightColor: NipponColors.nipponColor103,
    backgroundColor: Colors.blueGrey[50],
    //SHIRONERI
    canvasColor: NipponColors.nipponColor233,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      caption: GoogleFonts.poppinsTextTheme().caption.copyWith(
            fontWeight: FontWeight.bold,
          ),
      // button text
      subtitle2: GoogleFonts.poppinsTextTheme().subtitle2.copyWith(
            color: Colors.white,
          ),
      // app bar text
      headline4: GoogleFonts.courgetteTextTheme().headline4.copyWith(
            color: Colors.white,
            fontSize: 25.0,
          ),
      headline6: GoogleFonts.poppinsTextTheme().headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),

      bodyText1: GoogleFonts.poppinsTextTheme().bodyText1.copyWith(
            fontWeight: FontWeight.w800,
          ),
      bodyText2: GoogleFonts.poppinsTextTheme().bodyText2.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}
