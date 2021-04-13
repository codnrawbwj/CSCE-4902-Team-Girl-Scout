import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/cookie_card.dart';
import 'package:girl_scout_simple/components/cookie_cookies.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/components/cookie_dashboard.dart';
import 'package:girl_scout_simple/screens/seasonSetup.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;


import 'package:girl_scout_simple/models.dart';
import 'package:flutter/foundation.dart';

import '../components/constants.dart';
import '../components/constants.dart';
import '../components/constants.dart';
import '../components/constants.dart';
import '../components/constants.dart';
import '../components/constants.dart';
import '../components/sample_cookie.dart';


class Cookies extends StatefulWidget {
  static String id = '/Cookie';

  @override
  _CookiesState createState() => _CookiesState();
}

class _CookiesState extends State<Cookies> {
  void refresh () {
    print('refreshing members info...');
    setState(() {});
  }

  List<Widget> getCookieWidgetList({bool archive = false}) {
    var returnList = new List<Widget>();
    List<dynamic> cookies = globals.db.getAllCookie();

    for (Cookie c in cookies) {
      returnList.add(new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new AnimatedCookieCard(callingObj: this, cookie: c)
        ],
      ));
    }
  }

  _showCookieMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(200.0, 450.0, 40.0, 0.0),
      items: [
        PopupMenuItem<String>(
          child: const Text('Record Sale'),
          value: '1',
        ),
        PopupMenuItem<String>(
          child: const Text('Record Order'),
          value: '2',
        ),
        PopupMenuItem<String>(
          child: const Text('Record Tansfer'),
          value: '3',
        ),
        PopupMenuItem<String>(
          child: const Text('Add Cookie'),
          value: '4',
        ),
      ],
      elevation: 8.0,
    )
        .then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == '1') {
        //TODO: Implement a functionality
        print("Record Sale");
      }
      if (itemSelected == '2') {
        //TODO: Implement a functionality
        print("Record Order");
      }
      if (itemSelected == '3') {
        //TODO: Implement a functionality
        print("Record Transfer");
      }
      if (itemSelected == '4') {
        //TODO: Implement a functionality
        print("Add Cookie");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new SampleCookie())
        ).then((value) => {
          setState(() {})
        },);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSeasonStarted = db.isSeasonStarted();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: kLightGreenColor,
            appBar: AppBar(
              title: Text(
                'Cookie Tracker',
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: kWhiteColor),
              ),
              backgroundColor: kPrimaryColor,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "Tracker"),
                Tab(text: "Cookies"),
                Tab(text: "Seasons"),
              ]
            ),
              actions: <Widget>[
                //search, grid, list, export.. do we need list and grid?
                GestureDetector(onTap: () {
                  //TODO: implement functionality
                }, child: Icon(Icons.search, color: kWhiteColor),),
                SizedBox(width: 10.0),
                GestureDetector(onTap: () {
                  //TODO: implement functionality
                }, child: Icon(Icons.get_app, color: kWhiteColor),),
                SizedBox(width: 10.0),
              ],
          ),
          body: TabBarView(
                children: [
                    isSeasonStarted ?
                        CookieDashboard(callingObj: this) // display dashboard
                            :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Center( // display buttons
                                  child: Text("Cookie season has not been started", style: TextStyle(fontSize: 20.0),),
                              ),
                              SizedBox(height: 20.0),
                              Center( // display buttons
                                  child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                      child: MaterialButton(
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Start Season", style: TextStyle(fontSize: 20.0),),
                                          ),
                                          textColor: kWhiteColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(8.0),
                                          ),
                                          color: kGreenColor,
                                          onPressed: () async { //enable button
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) => new SeasonSetup()
                                                  )
                                              ).then((value) => setState(() {}));
                                          },
                                      ),
                                  ),
                              ),
                          ]
                      ),
                  ListView(
                    // children: getCookieWidgetList(),
                  ),
                  ListView(),
            ],
          ),
            floatingActionButton: isSeasonStarted ? FloatingActionButton(
              onPressed: () {
                _showCookieMenu();
              },
              child: Icon(Icons.add),
              backgroundColor: kGreenColor,
              shape: CircleBorder(),
            ) : null
            )
        ),
      );
  }
}
