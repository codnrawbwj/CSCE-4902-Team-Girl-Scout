import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/images_by_grade.dart';
import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/member_container.dart';
//import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/add.dart';
import 'package:girl_scout_simple/models.dart';

class MemberPageRoute extends CupertinoPageRoute {
  MemberPageRoute()
      : super(builder: (BuildContext context) => new Members());

  // I need this to stop sliding in. It looks terrible
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new Members());
  }
}


class Members extends StatefulWidget {
  static String id = '/Members';
  Row addedMember;

  Members({this.addedMember = null});

  @override
  _MembersState createState() => _MembersState();
}


class _MembersState extends State<Members> {

  bool expanded = true;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: DefaultTheme().theme,
      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "ALL"),
                Tab(text: "DAISY"),
                Tab(text: "BROWNIE"),
                Tab(text: "JUNIOR"),
                Tab(text: "CADETTE"),
                Tab(text: "SENIOR"),
                Tab(text: "AMBASSADOR"),
              ],
            ),
            title: const Text(
              'Members',
              style: TextStyle(
                color: kBlackColor,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            actions: <Widget>[
              //search, grid, list, export.. do we need list and grid?
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.search, color: kBlackColor,),),
              SizedBox(width: 10.0),
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.apps, color: kBlackColor,),),
              SizedBox(width: 10.0),
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.format_list_bulleted, color: kBlackColor,),),
              SizedBox(width: 10.0),
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.get_app, color: kBlackColor,),),
              SizedBox(width: 10.0),
            ],
            backgroundColor: kWhiteColor,

          ),
          backgroundColor: kLightGreyBackgroundColor,
          //Note: ListView makes the page vertically scrollable.
          body: TabBarView(
            children: [
              ListView( //all
                  children: getMemberWidgetList(gradeEnum.ALL)),
              ListView( //daisy
                  children: getMemberWidgetList(gradeEnum.DAISY)),
              ListView( //bownie
                  children: getMemberWidgetList(gradeEnum.BROWNIE)),
              ListView( //cadette
                  children: getMemberWidgetList(gradeEnum.JUNIOR)),
              ListView( //senior
                  children: getMemberWidgetList(gradeEnum.CADETTE)),
              ListView( //senior
                  children: getMemberWidgetList(gradeEnum.SENIOR)),
              ListView( //ambassador
                  children: getMemberWidgetList(gradeEnum.AMBASSADOR)),
            ],
          ),
          floatingActionButton: FloatingActionButton( //pressing this creates options for editing members. its fancy. im sorry, i got carried away
            onPressed: ()  {
              //TODO manage team members with actions such as add, delete, move, and edit
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  new Add(title: 'Add Member')));
              setState(() {

              });
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
        ),
      ),
    );
  }
}
