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

class CookieDashboard extends StatefulWidget {
  CookieDashboard({this.callingObj});

  final dynamic callingObj;

  @override
  _CookieDashboardState createState() => _CookieDashboardState();
}

class _CookieDashboardState extends State<CookieDashboard> {
  List<Widget> _restockList;
  List<charts.Series<_Day, String>> _seriesCookieSalesData;
  List<charts.Series<_Flavor, String>> _seriesCookiesPerFlavorData;
  List<charts.Series<_Scout, String>> _seriesCookiesPerScoutData;
  Box<dynamic> _salesBox;

  _getCookieRestock() {
    var cookieRestock = globals.db.getCookieRestock();
    _restockList = new List<Widget>();

    for (Cookie cookie in cookieRestock) {
      if (cookie != null) {
        _restockList.add(
            new ListTile(
                title: Text(cookie.name + ' - #', style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,),
                leading: CircleAvatar(
                    //backgroundImage: FileImage(File(cookie.photoPath))
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  /*
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                      new MemberBadgeInfo(memberBadge: memberBadge))).then((
                      value) => setState(() {}));
                      */
                }
            )
        );
      }
    }
  }

  _getCookieSalesData() {
    _seriesCookieSalesData = List<charts.Series<_Day, String>>();
    var weeklyCookieSales = [0, 0, 0, 0, 0, 0, 0];
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    /*
    for (int day = 1; day <= 7; ++day) {
      if (today.weekday == DateTime.sunday)
        break;

      var earnedBadges = _badgeTagsBox.values.where((badge) =>
      (badge.dateAcquired ==
          (today.subtract(new Duration(days: today.weekday - day + 1)))));
      weeklyCookieSales[day - 1] = earnedBadges.length;
    }
*/
    //https://cs.uwaterloo.ca/~alopez-o/math-faq/node73.html
    int k = now.day;
    int m = now.month;
    int c = ((now.year - now.year%1000)/(100)).round();
    int y = now.year%1000;
    int w = ((k + (2.6 * m - .2).floor() - 2*c + y + (y/4).floor() + (c/4).floor())%7) + 2;

    weeklyCookieSales[w] += globals.db.getTotalCookiesSold();

      var cookieSales = [
        _Day('Sun', weeklyCookieSales[0]),
        _Day('Mon', weeklyCookieSales[1]),
        _Day('Tues', weeklyCookieSales[2]),
        _Day('Wed', weeklyCookieSales[3]),
        _Day('Thurs', weeklyCookieSales[4]),
        _Day('Fri', weeklyCookieSales[5]),
        _Day('Sat', weeklyCookieSales[6])
      ];

      _seriesCookieSalesData.add(
          charts.Series(
              domainFn: (_Day day, _) => day.day,
              measureFn: (_Day day, _) => day.quantity,
              id: 'Week',
              data: cookieSales,
              fillPatternFn: (_, __) => charts.FillPatternType.solid,
              colorFn: (_Day cookie, _) => charts.ColorUtil.fromDartColor(Colors.black)
          )
      );

  }

  _getCookieSalesPerFlavorData() {
    _seriesCookiesPerFlavorData = List<charts.Series<_Flavor, String>>();
    var cookieSalesPerFlavor = [0, 0, 0, 0, 0, 0, 0];
/*
      var earnedBadges = _badgeTagsBox.values.where((badge) =>
      (badge.dateAcquired ==
          (today.subtract(new Duration(days: today.weekday - day + 1)))));
      cookieSalesPerFlavor[day - 1] = earnedBadges.length;
    }
*/
      var cookiesPerFlavor = [
        _Flavor('Sun', cookieSalesPerFlavor[0]),
        _Flavor('Mon', cookieSalesPerFlavor[1]),
        _Flavor('Tues', cookieSalesPerFlavor[2]),
        _Flavor('Wed', cookieSalesPerFlavor[3]),
        _Flavor('Thurs', cookieSalesPerFlavor[4]),
        _Flavor('Fri', cookieSalesPerFlavor[5]),
        _Flavor('Sat', cookieSalesPerFlavor[6])
      ];

    _seriesCookiesPerFlavorData.add(
          charts.Series(
          domainFn: (_Flavor flavor, _) => flavor.flavor,
          measureFn: (_Flavor flavor, _) => flavor.quantity,
          id: 'Week',
          data: cookiesPerFlavor,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          colorFn: (_Flavor flavor, _) =>
              charts.ColorUtil.fromDartColor(Colors.black),
          labelAccessorFn: (_Flavor flavor, _) =>
            '${flavor.flavor}: \$${flavor.quantity.toString()}'
          )
      );
    }

  _getCookieSalesPerScoutData() {
    _seriesCookiesPerScoutData = List<charts.Series<_Scout, String>>();
    var cookieSalesPerScout = [0, 0, 0, 0, 0, 0, 0];
/*
      var earnedBadges = _badgeTagsBox.values.where((badge) =>
      (badge.dateAcquired ==
          (today.subtract(new Duration(days: today.weekday - day + 1)))));
      cookieSalesPerScout[day - 1] = earnedBadges.length;
    }
*/
    var cookiesPerScout = [
      _Scout('Sun', cookieSalesPerScout[0]),
      _Scout('Mon', cookieSalesPerScout[1]),
      _Scout('Tues', cookieSalesPerScout[2]),
      _Scout('Wed', cookieSalesPerScout[3]),
      _Scout('Thurs', cookieSalesPerScout[4]),
      _Scout('Fri', cookieSalesPerScout[5]),
      _Scout('Sat', cookieSalesPerScout[6])
    ];

    _seriesCookiesPerScoutData.add(
        charts.Series(
            domainFn: (_Scout scout, _) => scout.scout,
            measureFn: (_Scout scout, _) => scout.quantity,
            id: 'Week',
            data: cookiesPerScout,
            fillPatternFn: (_, __) => charts.FillPatternType.solid,
            colorFn: (_Scout scout, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (_Scout scout, _) =>
            '${scout.scout}: \$${scout.quantity.toString()}'
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic callingObj = widget.callingObj;

    _salesBox = Hive.box('sales');

    _getCookieRestock();
    _getCookieSalesData();
    _getCookieSalesPerFlavorData();
    _getCookieSalesPerScoutData();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' Weekly Sales:  \$' + globals.db.getTotalPrice().toString(), style: Theme.of(context).textTheme.bodyText2,),
              SizedBox(width: 50),
              Text(' Cookies Sold:  ' + globals.db.getTotalCookiesSold().toString(), style: Theme.of(context).textTheme.bodyText2,),
            ]
          ),
          ReusableCard(title: 'Cookie Restock',
            subtitle: _restockList.length.toString() + ' items',
            addIcon: false,
            cardChild: Column(
              children: ListTile.divideTiles(
                  context: context,
                  tiles: _restockList
              ).toList(),
            ),),

          //list of chart: https://google.github.io/charts/flutter/gallery.html
          //library: https://pub.dev/packages/charts_flutter
          ReusableCard(
            title: 'Cookie Sales', subtitle: '', addIcon: false,
            cardChild: Column(
              children: [
                Container(
                  height: 400,
                  padding: EdgeInsets.all(20),
                  child: charts.BarChart(
                    _seriesCookieSalesData,
                    animate: true,
                  ),
                ),
              ],
            ),),
          ReusableCard(
            title: 'Cookies Sold per Flavor', subtitle: '', addIcon: false,
            cardChild: Column(
              children: [
                Container(
                  height: 400,
                  padding: EdgeInsets.all(20),
                  child: charts.BarChart(
                    _seriesCookiesPerFlavorData,
                    animate: true,
                    vertical: false,
                  ),
                ),
              ],
            ),),
          ReusableCard(
            title: 'Cookies Sold per Scout', subtitle: '', addIcon: false,
            cardChild: Column(
              children: [
                Container(
                  height: 400,
                  padding: EdgeInsets.all(20),
                  child: charts.BarChart(
                    _seriesCookiesPerScoutData,
                    animate: true,
                    vertical: false,
                  ),
                ),
              ],
            ),),
          SizedBox(height: 50.0),
          Center( // display buttons
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: MaterialButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("End Season", style: TextStyle(fontSize: 20.0),),
                ),
                textColor: kWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                color: kGreenColor,
                onPressed: () async { //end season button
                    globals.db.endSeason();
                    callingObj.refresh();
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
class _Day {
  String day;
  int quantity;

  _Day(this.day, this.quantity);
}

class _Flavor {
  String flavor;
  int quantity;

  _Flavor(this.flavor, this.quantity);
}

class _Scout {
  String scout;
  int quantity;

  _Scout(this.scout, this.quantity);
}