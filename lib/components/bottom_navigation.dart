
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
      // The background color will decide all pages' background color
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.poll_outlined),
              title: Text('Dashboard'),
              backgroundColor: Theme.of(context).primaryColor
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              title: Text('Members'),
              backgroundColor: Theme.of(context).primaryColor
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              title: Text('Badges'),
              backgroundColor: Theme.of(context).primaryColor
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              title: Text('Settings'),
              backgroundColor: Theme.of(context).primaryColor
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).hintColor,
          unselectedItemColor: Theme.of(context).hintColor,
          onTap: _onItemTapped,
        ),
    );
  }
}

//cookie tracker options: business_center, attach_money, calendar, pie_chart