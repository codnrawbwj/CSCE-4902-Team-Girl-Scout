import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/bottom_navigation.dart';
import 'package:girl_scout_simple/screens/dashboard.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:girl_scout_simple/screens/collection.dart';
import 'package:girl_scout_simple/screens/cookie.dart';
import 'package:girl_scout_simple/screens/settings.dart';
import 'package:girl_scout_simple/components/globals.dart';

import 'package:hive/hive.dart';

import 'components/default_theme.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';


void main() async{
  print('starting init');
  await db.initDB();
  print('finished init');

  runApp(Home());
}

class Home extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
      theme: DefaultTheme.lightTheme,
      // darkTheme: DefaultTheme.darkTheme,
      routes: {
        BottomNavigation.id: (context) => BottomNavigation(),
        Dashboard.id: (context) => Dashboard(),
        Members.id: (context) => new Members(),
        Collection.id: (context) => Collection(),
        Cookies.id: (context) => Cookies(),
        Settings.id: (context) => Settings(),
      },
    );
  }
}
