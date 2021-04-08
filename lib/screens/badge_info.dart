import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
import 'package:girl_scout_simple/models.dart';

class BadgeInfo extends StatefulWidget {
  //TODO: complete parameters
  BadgeInfo({this.badge});

  final Badge badge; //(ex) Add Member

  static String id = '/BadgeInfo';
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<BadgeInfo> {

  Badge badge;

  Future<String> alertPopupArchive(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notice'),
            content: Text((widget.badge.isArchived == 'Yes') ? 'Do you wish to set this badge to active?' : 'Do you wish to set this badge to inactive?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: ()async {
                  if(widget.badge.isArchived == 'Yes')
                    widget.badge.isArchived = 'No';
                  else
                    widget.badge.isArchived = 'Yes';
                  widget.badge.save();
                 // widget.callingObj.refresh();
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

  void refresh () {
    print('refreshing badge info...');
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    badge = widget.badge;
    var requirementList = new List<Widget>();


    for (var i in badge.requirements) {
      if (i != "") {
        requirementList.add(
          new ListTile(
              title: Text(i, style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1,),
              leading: const Icon(Icons.check),
          )
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        title: Text(
          badge.name,
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
          GestureDetector(onTap: () async {
            if(await alertPopupArchive(context) == 'Yes') {
              Navigator.pop(context);
            }
          }, child: Icon(
                 (widget.badge.isArchived == 'Yes') ? Icons.unarchive  :  Icons.archive,
                color: Theme.of(context).hintColor),),
          SizedBox(width: 15.0),
        ],
        backgroundColor: kDarkGreyColor,),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
                shrinkWrap: true,
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
                                  image: FileImage(File(badge.photoPath)),
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

                                Text(badge.name, style: Theme
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
                          new Text(badge.description, style: Theme
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
                      Column(
                        children: requirementList,
                      )
                    ],
                  )
                ]
            )
        ),
      ),
    );
  }
}
