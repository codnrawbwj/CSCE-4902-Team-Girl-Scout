import 'dart:io';
import 'package:intl/intl.dart';
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

class MemberBadgeInfo extends StatefulWidget {
  //TODO: complete parameters

  MemberBadgeInfo({this.memberBadge});

  final BadgeTag memberBadge;

  static String id = '/MemberInfo';
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<MemberBadgeInfo> {

  BadgeTag memberBadge;
  var changedChecks = new Map<String, bool>();

  @override
  Widget build(BuildContext context) {
    memberBadge = widget.memberBadge;
    var requirementList = new List<Widget>();


    memberBadge.requirementsMet.forEach((req, met) {
      if (req != "") {
        changedChecks[req] = (met == 'Yes') ? true : false ;
        requirementList.add(
          new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.platform,
                title: Text(req, style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,),
                value: changedChecks[req],
                onChanged: (bool value) {
                  setState(() {
                    changedChecks[req] = value;
                    memberBadge.requirementsMet[req] = value ? 'Yes' : 'No';
                    print(changedChecks[req]);
                    print(req);
                    if( !memberBadge.requirementsMet.containsValue('No') ) {
                      memberBadge.completedRequirements = 'Yes';
                      memberBadge.status = 'Awaiting Badge';
                      this.setState(() {});
                    }
                    else {
                      memberBadge.completedRequirements = 'No';
                      memberBadge.status = 'Incomplete';
                      memberBadge.dateAcquired = null;
                      this.setState(() {});
                    }
                    memberBadge.save();
                  });
                }
              );
            }
          )
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        title: Text(
          (memberBadge.badge.first as Badge).name,
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          //search, grid, list, export.. do we need list and grid?
          GestureDetector(onTap: () {
            //TODO: implement functionality
          }, child: Icon(Icons.edit, color: Theme.of(context).hintColor),),
          SizedBox(width: 15.0),
          GestureDetector(onTap: () {
            //TODO: implement functionality
          }, child: Icon(Icons.delete, color: Theme.of(context).hintColor),),
          SizedBox(width: 15.0),
        ],
        backgroundColor: kDarkGreyColor,),
      body: SingleChildScrollView(
        child: Padding(
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
                                  image: FileImage(File((memberBadge.badge.first as Badge).photoPath)),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Text((memberBadge.badge.first as Badge).name, style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2,),

                              ]
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: 30.0),
                  Row(children: <Widget>[
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('Description', style: Theme
                              .of(context)
                              .textTheme
                              .headline2,),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 10.0),
                  Row(children: <Widget>[
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text((memberBadge.badge.first as Badge).description, style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 30.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Requirements', style: Theme
                          .of(context)
                          .textTheme
                          .headline2,),
                      SizedBox(height: 10.0),
                      ListView(
                        shrinkWrap: true,
                        children: requirementList,
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(children: <Widget>[
                    new Flexible(
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text('Status:  ', style: Theme
                              .of(context)
                              .textTheme
                              .headline5,),
                          new Text(memberBadge.status, style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                            ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 10.0),
                  Row(children: <Widget>[
                    new Flexible(
                      child:
                        (memberBadge.status == 'Acquired') ?
                          new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                              new Text( 'Date Acquired: ', style: Theme
                                .of(context)
                                .textTheme
                                .headline5,),
                              new Text(DateFormat.yMMMMd().format(memberBadge.dateAcquired), style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1,)
                            ]
                          ) :
                          (memberBadge.status == 'Awaiting Badge') ?
                            new Center(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              child: ElevatedButton(
                                child: Text('Award Badge'),
                                onPressed: () {
                                  memberBadge.status = 'Acquired';
                                  var now = DateTime.now();
                                  var today = DateTime(now.year, now.month, now.day);
                                  memberBadge.dateAcquired = today;
                                  memberBadge.save();
                                  this.setState(() {});}
                              )
                            ) :
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[ new Text( '', style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,)],
                            ),
                    )
                  ]),
                ]
            )
        ),
      ),
    );
  }
}
