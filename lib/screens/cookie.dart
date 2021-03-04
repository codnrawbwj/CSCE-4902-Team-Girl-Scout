import 'package:flutter/material.dart';

class Cookie extends StatefulWidget {
  static String id = '/Cookie';

  @override
  _CookieState createState() => _CookieState();
}

class _CookieState extends State<Cookie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
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
              Tab(text: "Sales"),
              Tab(text: "Orders"),
              Tab(text: "Transfers"),
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
                ListView(),
                ListView(),
                ListView(),
                ListView(),
                ListView(),
                ListView(),
          ],
        ),
          ),
      )
      );
  }
}
