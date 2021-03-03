import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';

class DefaultTheme{

  // static bool _isDarkTheme = true;
  // ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  //
  // void toggleTheme() {
  //   _isDarkTheme = !_isDarkTheme;
  //   notifyListeners();
  // }

  static ThemeData get lightTheme => ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kGreenColor,
    hintColor: kWhiteColor,
    scaffoldBackgroundColor: kLightGreenColor,
    focusColor: kCookieColor,
    highlightColor: kCookieLightColor,
    //fontFamily: 'Georgia',
    textTheme: TextTheme(
      //(ex) Title - Dashboard, Collection
      headline1: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: kWhiteColor),
      //(ex) ReusableCard Title - Undistributed, Badge, This Month
      headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kBlackColor),
      //(ex) Setting - About Us
      headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kBlackColor),
      //(ex) develop an app, annabelle enjoyed...
      bodyText1: TextStyle(
        fontSize: 15.0,
        color: kBlackColor,
      ),
      //(ex) 18 items, Coding for Good II
      bodyText2: TextStyle(
        fontSize: 16.0,
        color: kWhiteColor,
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kGreenColor,
    hintColor: kWhiteColor,
    scaffoldBackgroundColor: kLightGreenColor,

    //fontFamily: 'Georgia',
    textTheme: TextTheme(
      //(ex) Title - Dashboard, Collection
      headline1: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: kWhiteColor),
      //(ex) ReusableCard Title - Undistributed, Badge, This Month
      headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kBlackColor),
      //(ex) Setting - About Us
      headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kBlackColor),
      //(ex) develop an app, annabelle enjoyed...
      bodyText1: TextStyle(
        fontSize: 15.0,
        color: kBlackColor,
      ),
      //(ex) 18 items, Coding for Good II
      bodyText2: TextStyle(
        fontSize: 16.0,
        color: kWhiteColor,
      ),
    ),
  );
}






