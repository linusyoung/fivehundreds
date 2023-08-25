import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nippon_colors/nippon_colors.dart';

class AppTheme {
  AppTheme._();

  static const List<Color> background = [
    NipponColors.nipponColor239,
    NipponColors.nipponColor234,
  ];

  static const List<Color> canvas = [
    NipponColors.nipponColor248,
    NipponColors.nipponColor233,
  ];

  static const List<Color> textColor = [
    NipponColors.nipponColor233,
    NipponColors.nipponColor250,
  ];

  static const List<Color> disabled = [
    NipponColors.nipponColor248,
    Color(0xFFE0E0E0),
  ];

  static const Color win = NipponColors.nipponColor149;
  static const Color lose = NipponColors.nipponColor016;

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.teal,
    // SEIHEKI
    primaryColor: NipponColors.nipponColor168,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
        secondary: NipponColors.nipponColor168, background: background[0]),
    highlightColor: NipponColors.nipponColor100,
    disabledColor: disabled[0],
    //SHIRONERI
    canvasColor: canvas[0],
    dividerColor: NipponColors.nipponColor241,
    toggleButtonsTheme: ToggleButtonsThemeData(
      fillColor: NipponColors.nipponColor100,
      color: textColor[0],
      selectedColor: textColor[0],
      textStyle: GoogleFonts.montserratTextTheme().bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: textColor[0],
          ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      bodySmall: GoogleFonts.montserratTextTheme().bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor[0],
          ),
      titleMedium: GoogleFonts.montserratTextTheme().titleMedium?.copyWith(
            color: textColor[0],
          ),
      // button text
      titleSmall: GoogleFonts.montserratTextTheme().titleSmall?.copyWith(
            color: textColor[0],
          ),
      // app bar text
      headlineMedium:
          GoogleFonts.montserratTextTheme().headlineMedium?.copyWith(
                color: textColor[0],
                fontSize: 25.0,
              ),
      headlineSmall: GoogleFonts.montserratTextTheme().headlineSmall?.copyWith(
            color: textColor[0],
          ),
      titleLarge: GoogleFonts.montserratTextTheme().titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor[0],
          ),

      bodyLarge: GoogleFonts.montserratTextTheme().bodyLarge?.copyWith(
            color: textColor[0],
          ),
      bodyMedium: GoogleFonts.montserratTextTheme().bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor[0],
          ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    // SEIHEKI
    primaryColor: NipponColors.nipponColor168,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
        secondary: NipponColors.nipponColor168, background: background[1]),
    highlightColor: NipponColors.nipponColor103,
    //SHIRONERI
    canvasColor: canvas[1],
    toggleButtonsTheme: ToggleButtonsThemeData(
      fillColor: NipponColors.nipponColor103,
      color: textColor[1],
      selectedColor: textColor[1],
      textStyle: GoogleFonts.montserratTextTheme().bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: textColor[1],
          ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      bodySmall: GoogleFonts.montserratTextTheme()
          .bodySmall
          ?.copyWith(fontWeight: FontWeight.bold, color: textColor[1]),
      // button text
      titleSmall: GoogleFonts.montserratTextTheme().titleSmall?.copyWith(
            color: textColor[0],
          ),
      // app bar text
      headlineMedium:
          GoogleFonts.montserratTextTheme().headlineMedium?.copyWith(
                color: textColor[0],
                fontSize: 25.0,
              ),
      titleLarge: GoogleFonts.montserratTextTheme().titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor[1],
          ),

      bodyLarge: GoogleFonts.montserratTextTheme().bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: textColor[1],
          ),
      bodyMedium: GoogleFonts.montserratTextTheme().bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor[1],
          ),
    ),
  );
}
