import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class ThemeHelper {
  /*
  ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      )
   */
  static ThemeData lightTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kAppColor),
        useMaterial3: true,
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: kAppColor),
        primarySwatch: MaterialColor(0xFFd52b3b, kColorsMap),
        brightness: Brightness.light,
        primaryColor: kAppColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kBottomBarColor,
          selectedLabelStyle: GoogleFonts.quicksand(color: kAppColor)
        ),
        dividerColor: Colors.grey,
        primaryColorLight: kTextColor,
        hintColor: kSubTextColor,
        scaffoldBackgroundColor: kScaffoldColor,
        highlightColor: kBottomBarIconColor,
        buttonTheme: const ButtonThemeData(buttonColor: kButtonColor));
  }

  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: kAppColor),
      useMaterial3: true,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kDarkBottomBarColor,
          selectedLabelStyle: GoogleFonts.quicksand(color: Colors.white)
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
      primarySwatch: MaterialColor(0xFF112031, kColorsMap),
      brightness: Brightness.light,
      primaryColor: kDarkAppColor,
      primaryColorLight: kDarkTextColor,
      dividerColor: Colors.blueGrey.shade900,
      highlightColor: kDarkBottomBarIconColor,
      scaffoldBackgroundColor: kDarkScaffoldColor,
      hintColor: kSubTextColor,
      buttonTheme: const ButtonThemeData(buttonColor: kDarkButtonColor),
    );
  }
}
