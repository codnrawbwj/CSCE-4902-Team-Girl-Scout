import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/member_container.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
import 'package:girl_scout_simple/components/badge_container.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:girl_scout_simple/screens/addEditMember.dart';
import 'package:girl_scout_simple/components/badge_card.dart';

class MemberInfo extends StatefulWidget {
  //TODO: complete parameters
  MemberInfo({@required this.member, this.callingObj});
  final Member member; //(ex) Add Member
  final dynamic callingObj;

  static String id = '/MemberInfo';
  @override
  _AddState createState() => _AddState();

}

class _AddState extends State<MemberInfo> {

  String name;
  String team;
  String gradeString;
  String month;
  int day;
  int year;
  String imageLocation;

  Future<String> alertPopupArchive(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Notice'),
                content: Text((widget.member.isArchived == 'Yes') ? 'Do you wish to unarchive this member?' : 'Do you wish to archive this member?'),
                actions: <Widget>[
                    FlatButton(
                        child: Text('Yes'),
                        onPressed: ()async {
                            if(widget.member.isArchived == 'Yes')
                                widget.member.isArchived = 'No';
                            else
                                widget.member.isArchived = 'Yes';
                            widget.member.save();
                            widget.callingObj.refresh();
                            Navigator.pop(context, 'Yes');
                        },
                    ),
                    FlatButton(
                        child: Text('No'),
                        onPressed: ()async {
                            Navigator.pop(context, 'No');
                        },
                    ),
                ],
            );
        }
    );
    return result;
  }

  List<Widget> getScoutBadgesWidgetList(String name) {
    var returnList = new List<Widget>();
    var memberBadgesList = globals.db.getMemberBadges(name);

    if (memberBadgesList != null) {
      print('creating member\'s badges widgets');
      for (var i in memberBadgesList) {
        print(i.status);
        Badge memberBadge = i.badge.first;
        Grade badgeGrade = memberBadge.grade.first;
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new BadgeCard(grade: badgeGrade.name,
                  name: memberBadge.name,
                  description: memberBadge.description,
                  requirements: memberBadge.requirements,
                  quantity: 0,
                  //getBadgeNum(describeEnum(i.grade), i.name),
                  photoLocation: memberBadge.photoPath,
                  isMemberBadge: true,
                  memberBadge: i,
                  callingObj: this),
            ]));
      }
    }
    print('returning member\'s badges widgets');
    return returnList;
  }

  void refresh () {
    print('refreshing members info...');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    name = widget.member.name;
    team = widget.member.team;
    gradeString = describeEnum((widget.member.grade.first as Grade).name);
    gradeString = gradeString[0] + gradeString.substring(1).toLowerCase();
    month = DateFormat.MMMM().format(widget.member.birthday);
    day = widget.member.birthday.day;
    year = widget.member.birthday.year;
    imageLocation = widget.member.photoPath;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        title: Text(
          name,
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          //search, grid, list, export.. do we need list and grid?
          GestureDetector(onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => new Add(title: 'Edit Member', member: widget.member, callingObj: widget.callingObj))).
                          then((value) {setState(() {});
            });
          }, child: Icon(Icons.edit, color: Theme.of(context).hintColor),),
          SizedBox(width: 15.0),
          GestureDetector(
              onTap: () async {
                if(await alertPopupArchive(context) == 'Yes') {
                  Navigator.pop(context);
                }
              },
              child: Icon(
                  (widget.member.isArchived == 'Yes') ? Icons.unarchive : Icons.archive ,
                  color: Theme.of(context).hintColor),),
          SizedBox(width: 15.0),
        ],
        backgroundColor: kDarkGreyColor,),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(

                      children: <Widget>[
                        Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(File(imageLocation)),
                                        fit: BoxFit.scaleDown
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 6,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Text(name, style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline2,),
                                      Text(team, style: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle1,),
                                    ]
                                ),
                              ),
                            ]
                        ),

                      ]
                  )
              ),
              SizedBox(height: 10.0),
              ReusableCard(
                title: 'Scout\'s Badges',
                subtitle: 'All',
                addIcon: true,
                member: widget.member,
                cardChild:
                  Column(
                    children: <Widget>[
                      Column(
                          children: getScoutBadgesWidgetList(name)
                          )
                    ],
                  ),
                callingObj: this,
                ),
            ]
        ),
      ),
    );
  }
}