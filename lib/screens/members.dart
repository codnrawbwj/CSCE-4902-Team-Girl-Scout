import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:girl_scout_simple/components/member_card.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/images_by_grade.dart';
import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/screens/addEditMember.dart';
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


//this function also add the add member card at the end of the list.
  List<Widget> getMemberWidgetList({@required gradeEnum grade, bool archive = false}) {
      var returnList = new List<Widget>();
      List<dynamic> members = globals.db.getMembersByGrade(grade);

      if(archive) {
          for (Member m in members) {
              if (m.isArchived == 'Yes') {
                print(m);
                returnList.add(new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new AnimatedMemberCard(callingObj: this, member: m),
                    ]));
              }
          }
      }
      else {
          for (Member m in members) {
              if (m.isArchived == 'No') {
                print(m);
                returnList.add(new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new AnimatedMemberCard(callingObj: this, member: m),
                    ]));
              }
          }
      }

      return returnList;
  }

  void refresh () {
    print('refreshing members page...');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 8,
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
                Tab(text: "INACTIVE"),
              ],
            ),
            title: Text(
              'Members',
              style: Theme.of(context).textTheme.headline1,
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
            backgroundColor: Theme.of(context).primaryColor,
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10)
              )
            ),

          ),
          backgroundColor: kLightGreyBackgroundColor,
          //Note: ListView makes the page verticy scrollable.
          body: TabBarView(
            children: [
              ListView( //all
                  children: getMemberWidgetList(grade: gradeEnum.ALL)),
              ListView( //daisy
                  children: getMemberWidgetList(grade: gradeEnum.DAISY)),
              ListView( //bownie
                  children: getMemberWidgetList(grade: gradeEnum.BROWNIE)),
              ListView( //cadette
                  children: getMemberWidgetList(grade: gradeEnum.JUNIOR)),
              ListView( //senior
                  children: getMemberWidgetList(grade: gradeEnum.CADETTE)),
              ListView( //senior
                  children: getMemberWidgetList(grade: gradeEnum.SENIOR)),
              ListView( //ambassador
                  children: getMemberWidgetList(grade: gradeEnum.AMBASSADOR)),
              ListView( //ambassador
                  children: getMemberWidgetList(grade: gradeEnum.ALL, archive: true)),
            ],
          ),
          floatingActionButton: FloatingActionButton( //pressing this creates options for editing members. its fancy. im sorry, i got carried away
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => new Add(title: 'Add Member'))).then((
                  value) {
                setState(() {});
              });
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            shape: CircleBorder(
            ),
          ),
        ),
      ),
    );
  }
}
