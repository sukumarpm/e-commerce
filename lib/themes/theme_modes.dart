// import 'package:flutter/material.dart';

// ThemeData lightMode = ThemeData(
//     colorScheme: const ColorScheme.light(
//   primary: Colors.white,
//   secondary: Color.fromARGB(255, 49, 41, 41),
//   tertiary: Color(0xFf169839),
//   inversePrimary: Color.fromARGB(255, 134, 178, 207),
//   primaryFixed: Colors.white,
// ));
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const COLOR_PRIMARY = Colors.black;
const COLOR_WHITE = Colors.white;
const MY_THEME = Color.fromARGB(255, 3, 4, 3);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: COLOR_PRIMARY,
    secondaryHeaderColor: COLOR_WHITE,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: COLOR_WHITE,
        selectedItemColor: COLOR_PRIMARY,
        unselectedItemColor: Colors.grey),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      secondary: Color.fromARGB(255, 49, 41, 41),
      tertiary: Colors.black,
      inversePrimary: Color.fromARGB(255, 134, 178, 207),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(color: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.black,
            focusColor: Colors.black,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide.none))),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.sen(
            textStyle: const TextStyle(color: COLOR_PRIMARY, fontSize: 16))),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: COLOR_PRIMARY),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
                color: COLOR_WHITE, fontSize: 16, fontFamily: 'Sen')),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0)),
            shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: WidgetStateProperty.all<Color>(COLOR_PRIMARY))),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: const Color(0xffE3EBF2),
    ));

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: COLOR_WHITE,
  secondaryHeaderColor: COLOR_PRIMARY,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: COLOR_PRIMARY,
      selectedItemColor: COLOR_WHITE,
      unselectedItemColor: Colors.grey),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.all<Color>(Colors.grey),
    thumbColor: WidgetStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
    filled: true,
    fillColor: const Color(0xffE3EBF2),
  ),
  textTheme: TextTheme(
      titleLarge: GoogleFonts.sen(
          textStyle: const TextStyle(color: COLOR_WHITE, fontSize: 16))),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
              color: COLOR_PRIMARY, fontSize: 16, fontFamily: 'Sen')),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0)),
          shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: WidgetStateProperty.all<Color>(COLOR_WHITE))),
);
