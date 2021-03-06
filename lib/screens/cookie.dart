import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/cookie_card.dart';
import 'package:girl_scout_simple/components/cookie_cookies.dart';
import 'package:girl_scout_simple/screens/recordSale.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/components/cookie_dashboard.dart';
import 'package:girl_scout_simple/components/cookie_widgets.dart';
import 'package:girl_scout_simple/screens/seasonSetup.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;


import 'package:girl_scout_simple/models.dart';
import 'package:flutter/foundation.dart';

import 'package:girl_scout_simple/screens/addCookie.dart';


class Cookies extends StatefulWidget {
  static String id = '/Cookie';

  @override
  _CookiesState createState() => _CookiesState();
}

class _CookiesState extends State<Cookies>  with SingleTickerProviderStateMixin {

  TabController _controller;
  bool isSeasonStarted;
  bool isSeasonOver;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3, initialIndex: 0);
    _controller.addListener(refresh);
  }

  @override
  void dispose() {
    //_controller.removeListener(refresh);
    _controller.dispose();
    super.dispose();
  }

  void refresh () {
    print('refreshing cookie tracker...');
    print("tab index " + _controller.index.toString());
    setState(() {});
  }

  List<Widget> getSeasonWidgetList() {
      List<Widget> returnList = new List<Widget>();
      List<dynamic> seasons = globals.db.getSeasons();
      String title;

      seasons.sort((a, b) => b.year.compareTo(a.year));
      for (Season season in seasons) {
        if (DateTime.now().year == season.year)
          title = 'Current Season';
        else
          title = season.year.toString();
        print(season);
        returnList.add(new Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: ListTile(
                title: Text(title,
                            textAlign: TextAlign.center,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  /*
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                        new MemberBadgeInfo(memberBadge: memberBadge))).then((value) => setState(() {}) );

                     */
                },
                contentPadding: EdgeInsets.all(15.0),
            )
        ));
      }

      return returnList;
  }

  FloatingActionButton addCookieButton() {
    return _controller.index == 1 ?
        isSeasonStarted ?
            FloatingActionButton(
                onPressed: () {
                _showCookieMenu();
                },
                child: Icon(Icons.add),
                backgroundColor: kGreenColor,
                shape: CircleBorder(),
            ) :
            FloatingActionButton(
                onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(
                builder: (context) => new AddCookie()
                )
                ).then((value) => setState(() {}));
                },
                child: Icon(Icons.add),
                backgroundColor: kGreenColor,
                shape: CircleBorder(),
            ) :
      null;
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
    ).then<void>((String itemSelected) {
        if (itemSelected == null) return;

        if (itemSelected == '1') {
          print("Record Sale");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => new RecordSale())
          );
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
            MaterialPageRoute(builder: (context) => new AddCookie())
          ).then((value) => {
            setState(() {})
          },);
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    isSeasonOver = db.isSeasonOver();
    isSeasonStarted = db.isSeasonStarted();

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
                    controller: _controller,
                    isScrollable: true,
                    tabs: [
                      Tab(text: "Tracker"),
                      Tab(text: "Cookies"),
                      Tab(text: "Seasons"),
                    ]
                ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                    isSeasonStarted ?
                        CookieDashboard(callingObj: this) // display dashboard
                            :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Center( // display buttons
                                  child: isSeasonOver?
                                  Text("Cookie season is over", style: TextStyle(fontSize: 20.0),)  :
                                  Text("Cookie season has not been started", style: TextStyle(fontSize: 20.0),)
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
                                          onPressed: isSeasonOver ?
                                              null :
                                              () async { //enable button
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
                    children: getCookieWidgetList(callingObj: this),
                  ),
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: getSeasonWidgetList())
                      )
                    ]
                  ),
            ],
          ),
            floatingActionButton: addCookieButton()
        ),
      )
    );
  }
}
