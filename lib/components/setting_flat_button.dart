// import 'dart:js';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:girl_scout_simple/components//setting_flat_popup.dart';
import 'package:girl_scout_simple/components/default_theme.dart';
import 'package:girl_scout_simple/components/theme_config.dart';


class SettingFlatButton extends StatelessWidget {

  SettingFlatButton({@required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: (){
        if(title == 'Delete All Data') {
          AlertPopup(context);
        }
        else if(title == 'About Us'){
          AboutUsPopup(context);
        }
        else if(title == 'Privacy Policy'){
          PrivacyPolicyPopup(context);
        }
        else if(title == 'Terms of Use'){
          TermsOfUsePopup(context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title == 'Delete All Data' ? Text(title, style: TextStyle(fontSize: 17, color: Colors.red),) :
          Text(title, style: TextStyle(fontSize: 17, color: Colors.black),),
          Icon(Icons.arrow_forward_ios, color: Colors.black12,),
        ],
      ),
    );
  }
}