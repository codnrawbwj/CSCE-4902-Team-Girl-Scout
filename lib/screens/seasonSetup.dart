import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:girl_scout_simple/screens/addCookie.dart';
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
import 'package:charts_flutter/flutter.dart' as charts;

class SeasonSetup extends StatefulWidget {
  //TODO: complete parameters
  SeasonSetup();

  static String id = '/SeasonSetup';
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<SeasonSetup> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        title: Text(
          'Season Setup',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                      child: Text('Please make sure that the cookies have the correct prices and inventory. '
                            'Archived cookies will be faded and unavailable for sale.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20.0,
                                    color: kBlackColor),
                      )
                  ),
                  SizedBox(height: 30.0),
                  Column(
                      children: <Widget>[
                        Text('Add cookie cards here',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: kBlackColor),
                        )
                      ]
                  ),
                  SizedBox(height: 50.0),
                  Center( // add cookie button
                      child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.add),
                        ),
                        textColor: kWhiteColor,
                        shape: CircleBorder(),
                        color: kGreenColor,
                        onPressed: () async { //enable button
                          //TODO: send to add cookie page
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => new AddCookie()
                              )
                          ).then((value) => {
                          setState(() {})
                          },);
                        },
                      ),
                    ),
                    SizedBox(height: 30.0),
                ],
                  )
            )
        ),
      floatingActionButton: FloatingActionButton.extended( //pressing this creates options for editing members. its fancy. im sorry, i got carried away
          onPressed: () {
              globals.db.startSeason();
              Navigator.pop(context);
          },
          label: Text('Start Season'),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
