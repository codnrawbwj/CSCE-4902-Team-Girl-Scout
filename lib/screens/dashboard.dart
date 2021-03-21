import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
// import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:girl_scout_simple/screens/memberBadge_info.dart';
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
  Widget build(BuildContext context) {
    var undistributedMemberBadges = globals.db.getUndistributedMemberBadges();
    var undistributedList = new List<Widget>();
    _badgeTagsBox = Hive.box('badgeTags');
    _seriesWeeklyData = List<charts.Series<_Badge,String>>();
    _getData();

    for (BadgeTag memberBadge in undistributedMemberBadges) {
      if (memberBadge != null) {
        Member member = memberBadge.member.first;
        Badge badge = memberBadge.badge.first;
        undistributedList.add(
            new ListTile(
              title: Text(member.name + ' - ' + badge.name, style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1,),
              leading: CircleAvatar (
                backgroundImage: FileImage(File(member.photoPath))
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                    new MemberBadgeInfo(memberBadge: memberBadge))).then((value) => setState(() {}) );
              }
            )
        );
      }
    }

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
                Text(globals.db.getMemberCount().toString() +  ' members', style: Theme.of(context).textTheme.bodyText2,),
                SizedBox(width: 10),
                Icon(Icons.check_circle, color: Theme.of(context).hintColor),
                SizedBox(width: 3),
                Text(globals.db.getBadgeCount().toString() + ' Badges', style: Theme.of(context).textTheme.bodyText2,),
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
              ReusableCard(title: 'Undistributed Badges', subtitle: undistributedMemberBadges.length.toString() + ' items', addIcon: false,
                cardChild: Column(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: undistributedList
                  ).toList(),
                ),),
              //list of chart: https://google.github.io/charts/flutter/gallery.html
              //library: https://pub.dev/packages/charts_flutter
              ReusableCard(title: 'Badges Awarded This Week', subtitle: '', addIcon: false,
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