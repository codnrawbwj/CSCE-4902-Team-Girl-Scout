import 'dart:io';

import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/member_info.dart';

//import 'globals.dart';

class AnimatedCookieCard extends StatefulWidget {

  final Cookie cookie;
  final bool isSetup;
  final dynamic callingObj;

  AnimatedCookieCard({@required this.cookie, this.isSetup, this.callingObj});
  @override
  _AnimatedCookieCard createState() => _AnimatedCookieCard();
}

class _AnimatedCookieCard extends State<AnimatedCookieCard> {

  String name;
  String imageLocation;
  String price;
  String quantity;
  String date;

  @override
  Widget build(BuildContext context) {
    name = widget.cookie.name;
    //imageLocation = widget.cookie.photoPath;
    price = widget.cookie.price.toString();
    quantity = widget.cookie.quantity.toString();
    date = widget.cookie.date.toString();

    return AnimatedContainer(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.91,
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(
          color: kLightGreyColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      duration: Duration(milliseconds: 100),

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //parentPage == 'Setting' ? ExcludeTitle() : IncludeTitle(title: title, subtitle: subtitle),
                //show only if subtitle is not null ('')
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(File(imageLocation)),
                          fit: BoxFit.scaleDown
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 7,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(name, style: Theme
                            .of(context)
                            .textTheme
                            .headline2,),
                        SizedBox(height: 20.0),
                        widget.isSetup ?
                            Text('\$ ' + price + '  Qty: ' + quantity, style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,) :
                            null,
                      ]
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                    children: <Widget>[
                    ]
                ),
              ],
            ),
            onTap: () {

            }
        ),
      ),
    );
  }
}