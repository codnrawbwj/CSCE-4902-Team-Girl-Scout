import 'dart:io';

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

class MemberInfo extends StatefulWidget {
  //TODO: complete parameters
  MemberInfo({@required this.data});
  final Data data; //(ex) Add Member

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

  @override
  Widget build(BuildContext context) {
    name = widget.data.name;
    team = widget.data.team;
    gradeString = widget.data.grade.toString();
    month = widget.data.birthMonth;
    day = widget.data.birthDay;
    year = widget.data.birthYear;
    imageLocation = widget.data.photoLocation;

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
                data: widget.data,
                cardChild:
                  Column(
                    children: <Widget>[
                      ListView(
                          shrinkWrap: true,
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

  void refresh () {
    print('refreshing...');
    setState(() {});
  }
}