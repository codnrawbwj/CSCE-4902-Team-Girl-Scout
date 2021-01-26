
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/screens/dashboard.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:girl_scout_simple/screens/collection.dart';
import 'package:girl_scout_simple/screens/settings.dart';

class BottomNavigation extends StatefulWidget {
  //navigation id
  static String id = '/BottomNavigation';

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Members(),
    Collection(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _widgetOptions.elementAt(_selectedIndex),
      /*
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
       */
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              title: Text('Dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('Member'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              title: Text('Badges'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kBlackColor,
          unselectedItemColor: kLightGreyColor,
          onTap: _onItemTapped,
        ),
    );
  }
}
