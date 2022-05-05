import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
      backgroundColor: const Color(0xFFFAFAFA),
      dialogBackgroundColor: const Color(0xFF383838),
      primaryColor: const Color(0xFFF56E22),
      hintColor: Colors.grey[400],
      disabledColor: Colors.grey[700],
      secondaryHeaderColor: Colors.deepOrangeAccent[400],
      errorColor: Colors.redAccent[700],
      splashColor: Colors.transparent,
      highlightColor: const Color(0xFF2374ED),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFFF56E22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline2: TextStyle(
            fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline3: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline4: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
        headline5: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
        headline6: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
        subtitle1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
        subtitle2: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
        bodyText2: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        caption: TextStyle(fontSize: 14.0, color: Color(0xFFAFAFAF)),
        button: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.white),
        overline: TextStyle(fontSize: 14.0),
      ).apply(
          // bodyColor: Colors.black,
          ));
}
