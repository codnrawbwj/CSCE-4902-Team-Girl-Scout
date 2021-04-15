import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/components/reusable_card.dart';
import 'package:girl_scout_simple/components/default_theme.dart';

class CookieCookies extends StatefulWidget {
  CookieCookies({this.callingObj});

  final dynamic callingObj;

  @override
  _CookieCookiesState createState() => _CookieCookiesState();
}

class _CookieCookiesState extends State<CookieCookies> {
  @override
  Widget build(BuildContext context) {
    dynamic callingObj = widget.callingObj;

    final logicalSize = MediaQuery.of(context).size;
    final double screenHeight = logicalSize.height;
    
    _showCookieMenu() {
      showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(0.0, 30.0, 25.0, 0.0),
          items: [
            PopupMenuItem<String>(
              child: const Text('Record Sale'),
              value: '1',
            ),
            PopupMenuItem<String>(
              child: const Text('Record Order'),
              value: '2',
            ),
            PopupMenuItem<String>(
              child: const Text('Record Transfer'),
              value: '3',
            ),
            PopupMenuItem<String>(
              child: const Text('Add Cookie'),
              value: '4',
            ),
          ],
        elevation: 8.0,
      )
      .then<void>((String itemSelected) {
        if (itemSelected == null) return;

        if(itemSelected == '1'){
          //TODO: Implement a functionality
          print("Record Sale");
        }
        if(itemSelected == '2'){
          //TODO: Implement a functionality
          print("Record Order");
        }
        if(itemSelected == '3'){
          //TODO: Implement a functionality
          print("Record Transfer");
        }
        if(itemSelected == '4'){
          //TODO: Implement a functionality
          print("Add Cookie");
        }
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          FloatingActionButton(
            onPressed: () {
              _showCookieMenu();
            },
            child: Icon(Icons.add),
            backgroundColor: kGreenColor,
            shape: CircleBorder(),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
