import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:girl_scout_simple/screens/addCookie.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/cookie_widgets.dart';

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
        child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text('Please make sure that the cookies have the correct prices and inventory. '
                              'Archived cookies will be faded and unavailable for sale.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0,
                                      color: kBlackColor),
                        )
                      ),
                  ),
                  SizedBox(height: 30.0),
                  Column(
                      children: getCookieWidgetList(callingObj: this),
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
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => new AddCookie()
                              )
                          ).then( (value) => setState(() {}) );
                        },
                      ),
                    ),
                    SizedBox(height: 30.0),
                ],
                  )
            ),
      floatingActionButton: FloatingActionButton.extended(
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
