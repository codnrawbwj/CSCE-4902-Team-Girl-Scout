import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/cookie_card.dart';
import 'dart:io';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/models.dart';



List<Widget> getCookieWidgetList({dynamic callingObj, bool archive = false}) {
  var returnList = new List<Widget>();
  List<dynamic> cookies = globals.db.getCookies();

  for (Cookie c in cookies) {
    returnList.add(new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new AnimatedCookieCard(callingObj: callingObj, isSetup: false, cookie: c)
      ],
    ));
  }

  return returnList;
}