import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/images_by_grade.dart';

//import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/reusable_card.dart';
import 'package:girl_scout_simple/components/badge_widgets.dart';
import 'package:girl_scout_simple/models.dart';

class Collection extends StatefulWidget {
  static String id = '/Collection';

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {

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
              'Badges',
              style: Theme.of(context).textTheme.headline1,
              // style: TextStyle(
              //   color: kBlackColor,
              //   fontWeight: FontWeight.bold,
              //   fontSize: 30.0,
              // ),
            ),
            actions: <Widget>[
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.search, color: Theme.of(context).hintColor),),
              SizedBox(width: 10.0),
              GestureDetector(onTap: () {
                //TODO: implement functionality
              }, child: Icon(Icons.get_app, color: Theme.of(context).hintColor),),
              SizedBox(width: 10.0),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10)
              )
            ),
            backgroundColor: kPrimaryColor,

          ),
          backgroundColor: kLightGreyBackgroundColor,
          //Note: ListView makes the page vertically scrollable.
          body: TabBarView(
            children: [
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'All', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                            children: getBadgeWidgetList(gradeEnum.ALL, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'All', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.ALL, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Daisy', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.DAISY, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Daisy', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.DAISY, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Brownie', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.BROWNIE, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Brownie', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.BROWNIE, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Junior', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.JUNIOR, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Junior', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.JUNIOR, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Cadette', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.CADETTE, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Cadette', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.CADETTE, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Senior', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.SENIOR, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Senior', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.SENIOR, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Ambassador', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.AMBASSADOR, false, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Ambassador', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.AMBASSADOR, false)
                    ///  ),
                    ///),
                  ]
              ),
              ListView(
                  children: <Widget>[
                    ReusableCard(
                      title: 'Badges', subtitle: 'Inactive', addIcon: true,
                      cardChild: Column(
                        children: <Widget>[
                          Column(
                              children: getBadgeWidgetList(gradeEnum.ALL, false, archive: true, callingObj: this)
                          ),
                        ],
                      ),
                    ),

                    ///THIS IS USED FOR PATCHES
                    ///ReusableCard(
                    ///  title: 'Patches', subtitle: 'Ambassador', addIcon: true,
                    ///  cardChild:
                    ///  ListView(
                    ///      shrinkWrap: true,
                    ///      children: getBadgeWidgetList(gradeEnum.AMBASSADOR, false)
                    ///  ),
                    ///),
                  ]
                ),
            ],
          ),
        ),
      ),
    );
  }
}
