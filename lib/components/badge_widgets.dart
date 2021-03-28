import 'dart:io';

import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'globals.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/badge_info.dart';
import 'package:girl_scout_simple/screens/memberBadge_info.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;


List<Widget> getBadgeWidgetList(gradeEnum grade, bool selectable, {bool archive = false, Member member}) {
  var returnList = new List<Widget>();
  List<dynamic> badges = globals.db.getBadgesByGrade(grade);

  if (archive) {
    for (Badge badge in badges) {
      if (badge.isArchived == 'Yes') {
        print(badge);
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new BadgeCard(
                  badge: badge,
                  selectable: selectable,
                  member: member,
                  isMemberBadge: false),
            ]));
      }
    }
  }
  else {
    for (Badge badge in badges) {
      if (badge.isArchived == 'No') {
        print(badge);
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new BadgeCard(
                  badge: badge,
                  selectable: selectable,
                  member: member,
                  isMemberBadge: false),
            ]));
      }
    }
  }
  return returnList;
}

class BadgeCard extends StatelessWidget {

  BadgeCard({this.badge, this.selectable = false, this.member, this.isMemberBadge, this.memberBadge, this.callingObj});

  final Badge badge;
  final bool selectable;
  final Member member;
  final bool isMemberBadge;
  final BadgeTag memberBadge;
  final dynamic callingObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.800,
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(
          color: kLightGreyColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //parentPage == 'Setting' ? ExcludeTitle() : IncludeTitle(title: title, subtitle: subtitle),
                //show only if subtitle is not null ('')
                Expanded(
                  flex: 3,
                  child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FileImage(File(badge.photoPath)),
                    fit: BoxFit.scaleDown
                ),
              ),
            ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 7,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(badge.name, style: Theme
                            .of(context)
                            .textTheme
                            .headline2,),
                        Text(badge.description, style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1,),
                      ]
                  ),
                ),
              ],
            ),
            onTap: () async{
              if (selectable) { //for adding member badges from badgelist
                    //add badge to scout list
                  if (member == null) {
                      print(
                          'YOU NEED TO PASS A  MEMBER IF YOU MAKE THE BADGECARD SELECTABLE!');
                      return;
                  }; //get member

                  if (await db.addBadgeTag(member, badge) == null) //if member already has badge, alert user
                      alertPopup(context);
                  else
                      Navigator.pop(context, true);
              }
              else {
                  if (isMemberBadge) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                          new MemberBadgeInfo(memberBadge: memberBadge, callingObj: callingObj)));
                  }
                  else {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                          new BadgeInfo(badge: badge)));
                  }
              }
            }
        ),
      ),
    );
  }
}

void alertPopup(BuildContext context) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('Member already has the selected badge'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()async {
                Navigator.pop(context, 'yes');
              },
            ),
          ],
        );
      }
  );
}
