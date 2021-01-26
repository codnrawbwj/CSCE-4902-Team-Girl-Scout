import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/components/globals.dart';

void AlertPopup(BuildContext context) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('All data will be deleted.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: ()async {

                db.deleteAllData();

                Navigator.pop(context, 'yes');
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: (){
                Navigator.pop(context, 'No');
              },
            ),
          ],
        );
      }
  );
}

void AboutUsPopup(BuildContext context) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: rootBundle.loadString('assets/about_us.md'), //TODO: Update About Us before publishing
                  builder: (BuildContext context, AsyncSnapshot <String> snapshot){
                    if(snapshot.hasData){
                      return Markdown(data: snapshot.data);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              FlatButton(
                child: Text('Close'),
                onPressed: (){
                  Navigator.pop(context, "");
                },
              ),
            ],
          ),
        );
      }
  );
}

void PrivacyPolicyPopup(BuildContext context) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: rootBundle.loadString('assets/privacy_policy.md'), //TODO: Update Privacy Policy before publishing
                      builder: (BuildContext context, AsyncSnapshot <String> snapshot){
                        if(snapshot.hasData){
                          return Markdown(data: snapshot.data);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),

                FlatButton(
                  child: Text('Close'),
                  onPressed: (){
                    Navigator.pop(context, 'Close');
                  },
                ),
              ]
          ),
        );
      }
  );
}

void TermsOfUsePopup(BuildContext context) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: rootBundle.loadString('assets/terms_of_use.md'), //TODO: Update Terms of Use before publishing
                  builder: (BuildContext context, AsyncSnapshot <String> snapshot){
                    if(snapshot.hasData){
                      return Markdown(data: snapshot.data);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              FlatButton(
                child: Text('Close'),
                onPressed: (){
                  Navigator.pop(context, 'Close');
                },
              )
            ],
          ),
        );
      }
  );
}