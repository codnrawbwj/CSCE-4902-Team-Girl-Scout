import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/bottom_navigation.dart';
import 'package:girl_scout_simple/screens/dashboard.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:girl_scout_simple/screens/collection.dart';
import 'package:girl_scout_simple/screens/settings.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:hive/hive.dart';


void main() async{
  print('starting init');
  await db.initDB();
  print('finished init');

  runApp(Home());
}

class Home extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigation(),
      routes: {
        BottomNavigation.id: (context) => BottomNavigation(),
        Dashboard.id: (context) => Dashboard(),
        Members.id: (context) => new Members(),
        Collection.id: (context) => Collection(),
        Settings.id: (context) => Settings(),
      },
    );
  }
}
