//import 'dart:js';

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
import 'package:girl_scout_simple/components/setting_flat_button.dart';
import 'package:girl_scout_simple/components/theme_config.dart';



class Settings extends StatefulWidget {
  static String id = '/Settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.headline1
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10)
            )
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.brightness_4),
          //     onPressed: () => currentTheme.toggleTheme(),
          //   )
          // ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        //Note: ListView makes the page vertically scrollable.
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // ReusableCard(parentPage: 'Setting', title: '', subtitle: '', addIcon: false,
              //     cardChild: Column(
              //       children: [
              //         //TODO: modify the subtitle to reflect actual name
              //         SettingFlatButton(title: "Theme",),
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //           child: Divider(height: 1, color: kLightGreyColor,),
              //         ),
              //         SettingFlatButton(title: "Notification"),
              //       ],
              //     ),
              // ),
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

