import 'package:flutter/material.dart';
import 'dart:core';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
// import 'package:girl_scout_simple/components/default_theme.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:girl_scout_simple/models.dart';

class Dashboard extends StatefulWidget {
  static String id = '/Dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<charts.Series<_Badge, String>> _seriesWeeklyData;
  Box<dynamic> _badgeTagsBox;

  _getData() {

    var weeklyBadgesEarned = [0, 0, 0, 0, 0, 0, 0];
     ///*
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    // ---------------- test data (remove when done testing) ---------------

    _badgeTagsBox.clear();
    print('loading badge data for chart');
    if (_badgeTagsBox.isEmpty) {
      var yesterday = today.subtract(new Duration(days: 1));
      var twodaysago = today.subtract(new Duration(days: 2));
      var threedaysago = today.subtract(new Duration(days: 3));
      var fourdaysago = today.subtract(new Duration(days: 4));
      var fivedaysago = today.subtract(new Duration(days: 5));
      var sixdaysago = today.subtract(new Duration(days: 6));

      for (int day = 0; day < 6; ++day) {
        _badgeTagsBox.add(BadgeTag.date(today));
      }

      for (int day = 0; day < 15; ++day) {
        _badgeTagsBox.add(BadgeTag.date(yesterday));
      }

      for (int day = 0; day < 10; ++day) {
        _badgeTagsBox.add(BadgeTag.date(twodaysago));
      }

      for (int day = 0; day < 12; ++day) {
        _badgeTagsBox.add(BadgeTag.date(threedaysago));
      }

      for (int day = 0; day < 7; ++day) {
        _badgeTagsBox.add(BadgeTag.date(fourdaysago));
      }

      for (int day = 0; day < 11; ++day) {
        _badgeTagsBox.add(BadgeTag.date(fivedaysago));
      }

      for (int day = 0; day < 8; ++day) {
        _badgeTagsBox.add(BadgeTag.date(sixdaysago));
      }
    }
    // ---------------------------------------------------------------------

    for(int day = 1; day <= 7; ++day) {
      if(today.weekday == DateTime.sunday)
        break;

      var earnedBadges = _badgeTagsBox.values.where((badge) =>
      (badge.dateAcquired ==
          (today.subtract(new Duration(days: today.weekday - day + 1)))));
      weeklyBadgesEarned[day - 1] = earnedBadges.length;
    }
    //*/

    var weeklyBadges = [
      _Badge('Sun', weeklyBadgesEarned[0]),
      _Badge('Mon', weeklyBadgesEarned[1]),
      _Badge('Tues', weeklyBadgesEarned[2]),
      _Badge('Wed', weeklyBadgesEarned[3]),
      _Badge('Thurs', weeklyBadgesEarned[4]),
      _Badge('Fri', weeklyBadgesEarned[5]),
      _Badge('Sat', weeklyBadgesEarned[6])
    ];

    _seriesWeeklyData.add(
        charts.Series(
            domainFn: (_Badge badge, _) => badge.day,
            measureFn: (_Badge badge, _) => badge.quantity,
            id: 'Week',
            data: weeklyBadges,
            fillPatternFn: (_, __) => charts.FillPatternType.solid,
            colorFn: (_Badge badge, _) => charts.ColorUtil.fromDartColor(Colors.black)
        )
    );

  }

  @override
  void initState() {
    super.initState();
    _badgeTagsBox = Hive.box('badgeTags');
    _seriesWeeklyData = List<charts.Series<_Badge,String>>();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // This removes the 'debug' banner.
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headline1,
            // style: TextStyle(
            //   color: Colors.white,
            //   fontWeight: FontWeight.bold,
            //   fontSize: 30.0,
            // ),
          ),
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15),
                Icon(Icons.group, color: Theme.of(context).hintColor),
                SizedBox(width: 3),
                //TODO: Count the actual number of members
                Text("13 members", style: Theme.of(context).textTheme.bodyText2,),
                SizedBox(width: 10),
                Icon(Icons.equalizer, color: Theme.of(context).hintColor),
                SizedBox(width: 3),
                //TODO: Count the actual number of collections
                Text("57 Collections", style: Theme.of(context).textTheme.bodyText2,),
                SizedBox(width: 20)
              ],
            ),
            preferredSize: Size.fromHeight(20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10)
            )
          ),
          backgroundColor: Theme.of(context).primaryColor,
          ),
        backgroundColor: kLightGreyBackgroundColor,
        //Note: ListView makes the page vertically scrollable.
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(width: 15),
              //     Icon(Icons.group),
              //     SizedBox(width: 3),
              //     //TODO: Count the actual number of members
              //     Text("13 members", style: Theme.of(context).textTheme.bodyText1,),
              //     SizedBox(width: 10),
              //     Icon(Icons.equalizer),
              //     SizedBox(width: 3),
              //     //TODO: Count the actual number of collections
              //     Text("57 Collections", style: Theme.of(context).textTheme.bodyText1,)
              //   ],
              // ),
              //TODO: Include list that reflects the undistributed badges/patches
              ReusableCard(title: 'Undistributed', subtitle: '18 items', addIcon: false,
                cardChild: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attachment),
                        SizedBox(width: 10.0),
                        Text('Digital Game Design I', style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attachment),
                        SizedBox(width: 10.0),
                        Text('Digital Game Design II', style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    ),
                  ],
                ),),
              //TODO: Replace with graph (probably line for every member?)
              //list of chart: https://google.github.io/charts/flutter/gallery.html
              //library: https://pub.dev/packages/charts_flutter
              ReusableCard(title: 'This Week', subtitle: '', addIcon: false,
                cardChild: Column(
                  children: [
                    Container(
                      height: 400,
                      padding: EdgeInsets.all(20),
                      child: charts.BarChart(
                        _seriesWeeklyData,
                        animate: true,
                      ),
                    ),
                  ],
                ),),
              //TODO: Replace with graph (probably line for every member?)
              ReusableCard(title: 'This Month', subtitle: '', addIcon: false,
                cardChild: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attachment),
                        SizedBox(width: 10.0),
                        Text('Digital Game Design I', style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attachment),
                        SizedBox(width: 10.0),
                        Text('Digital Game Design II', style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
class _Badge {
  String day;
  int quantity;

  _Badge(this.day, this.quantity);
}