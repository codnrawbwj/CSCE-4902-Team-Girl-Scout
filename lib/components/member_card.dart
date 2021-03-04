import 'dart:io';

import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/member_info.dart';

//import 'globals.dart';

class AnimatedMemberCard extends StatefulWidget {

  final Member member;

  AnimatedMemberCard({@required this.member});
  @override
  _AnimatedMemberCard createState() => _AnimatedMemberCard();
}

class _AnimatedMemberCard extends State<AnimatedMemberCard> {

  String name;
  String team;
  String imageLocation;

  @override
  Widget build(BuildContext context) {
    name = widget.member.name;
    team = widget.member.team;
    imageLocation = widget.member.photoPath;

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
                        Text(team, style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1,),
                      ]
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                    children: <Widget>[
//TODO add number of bagdes completed in an elegant way, can be a button that appears when scout is ready to be moved to higher rank
                    ]
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => new MemberInfo(member: widget.member)));
              setState(() {
                //update();
              });
              //TODO create funtion so that if state is triggered, bring up edit page with populated information for tapped scout
            }
        ),
      ),
    );
  }
}