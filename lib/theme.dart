import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
      backgroundColor: const Color(0xFFFFFFFF),
      dialogBackgroundColor: const Color(0xFF777777),
      primaryColor: const Color(0xFFF56E22),
      hintColor: Colors.grey[400],
      disabledColor: Colors.grey[700],
      secondaryHeaderColor: Colors.deepOrangeAccent[400],
      errorColor: Colors.redAccent[700],
      splashColor: Colors.transparent,
      highlightColor: const Color(0xFF2374ED),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline2: TextStyle(
            fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline3: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        headline5: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        subtitle2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        caption: TextStyle(fontSize: 14.0, color: Color(0xFFAFAFAF)),
        button: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
        overline: TextStyle(fontSize: 14.0),
      ).apply(
        bodyColor: Colors.white,
      ));
}
