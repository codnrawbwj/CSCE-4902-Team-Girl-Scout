import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/cookie_dashboard.dart';
import 'package:girl_scout_simple/screens/seasonSetup.dart';


import 'package:girl_scout_simple/models.dart';
import 'package:flutter/foundation.dart';


class Cookie extends StatefulWidget {
  static String id = '/Cookie';

  @override
  _CookieState createState() => _CookieState();
}

class _CookieState extends State<Cookie> {
  void refresh () {
    print('refreshing members info...');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isSeasonStarted = db.isSeasonStarted();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              'Cookie Tracker',
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: Theme.of(context).primaryColor,
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
              }, child: Icon(Icons.search, color: Theme.of(context).hintColor),),
              SizedBox(width: 10.0),
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.get_app, color: Theme.of(context).hintColor),),
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
                ListView(),
                ListView(),
          ],
        ),
          ),
      )
      );
  }
}
