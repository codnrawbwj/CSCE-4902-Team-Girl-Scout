import 'dart:io';

import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'globals.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/badge_info.dart';

class BadgeCard extends StatelessWidget {

  BadgeCard({this.grade, this.name, this.description, this.requirements,
    this.quantity, this.photoLocation, this.selectable = false, this.memberData});

  final gradeEnum grade;
  final String name;
  final String description;
  final List<String> requirements;
  final int quantity;
  final String photoLocation; //idk if we need this
  final bool selectable;
  final Data memberData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.800,
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

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    image: FileImage(File(photoLocation)),
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
                        Text(description, style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1,),
                      ]
                  ),
                ),
              ],
            ),
            onTap: () async{
              //TODO create funtion so that if state is triggered, bring up edit page with populated information for tapped scout
              if (selectable) {
                  //add badge to scout list
                if (memberData == null) {
                  print(
                      'YOU NEED TO PASS A  MEMBER IF YOU MAKE THE BADGECARD SELECTABLE!');
                  return;
                }
                Member member = db.getMember(memberData.name); //get member
                Badge badge = db.getBadge(name);

                await db.addBadgeTag(member, badge);
                Navigator.pop(context, true);
                }
              else {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => new BadgeInfo(badge: db.getBadge(name))));
                }
            }
        ),
      ),
    );
  }
}