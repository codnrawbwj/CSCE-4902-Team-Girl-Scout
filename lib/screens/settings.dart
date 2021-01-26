//import 'dart:js';

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
import 'package:girl_scout_simple/components/setting_flat_button.dart';


class Settings extends StatefulWidget {
  static String id = '/Settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DefaultTheme().theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              color: kBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          backgroundColor: kWhiteColor,
        ),
        backgroundColor: kLightGreyBackgroundColor,
        //Note: ListView makes the page vertically scrollable.
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ReusableCard(parentPage: 'Setting', title: '', subtitle: '', addIcon: false,
                  cardChild: Column(
                    children: [
                      //TODO: modify the subtitle to reflect actual name
                      SettingFlatButton(title: "Theme",),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(height: 1, color: kLightGreyColor,),
                      ),
                      SettingFlatButton(title: "Notification"),
                    ],
                  ),
              ),
              ReusableCard(parentPage: 'Setting', title: '', subtitle: '', addIcon: false,
                cardChild: Column(
                  children: [
                    //TODO: modify the subtitle to reflect actual name
                    SettingFlatButton(title: "iCloud Backup",),
                  ],
                ),
              ),
              ReusableCard(parentPage: 'Setting', title: '', subtitle: '', addIcon: false,
                cardChild: Column(
                  children: [
                    //TODO: modify the subtitle to reflect actual name
                    SettingFlatButton(title: "Report Errors",),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(height: 1, color: kLightGreyColor,),
                    ),
                    SettingFlatButton(title: "Give Feedback"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(height: 1, color: kLightGreyColor,),
                    ),
                    SettingFlatButton(title: "Review on App Store"),
                  ],
                ),
              ),
              ReusableCard(parentPage: 'Setting', title: '', subtitle: '', addIcon: false,
                  cardChild: Column(
                    children: [
                      SettingFlatButton(title: "About Us",),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(height: 1, color: kLightGreyColor,),
                      ),
                      SettingFlatButton(title: "Privacy Policy"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(height: 1, color: kLightGreyColor,),
                      ),
                      SettingFlatButton(title: "Terms of Use"),
                    ],
                  ),
              ),
              ReusableCard(parentPage: 'Setting', title: '', subtitle: '', addIcon: false,
                cardChild: SettingFlatButton(
                    title: "Delete All Data"
                ),
                ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}

