//Hopefully this file will contain all data for members and return a list of widgets
//I am not sure that this is acceptable, but i believe that having all members accessable at a global level is optimal for our program to function efficiently.
//this file contains 8 lists and a couple functions for placing scouts into those lists based on thier level.abstract
//return funtion of this file returns a list of rows, each holding a member and an edit widget. pretty neat right? flutter is great!
import 'dart:io';

import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/components/badge_card.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/models.dart';


import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

//returns 0 if scout is placed in a list, this can be used my the add_member_card to verify that all fields are filled out
void addBadgeToList(String grade, String name, String description, List<String> requirements, String photoLocation) {
  if (name == '') return null;
  //all other variables should come from a list the user has to chose, meaning that there is no room for empty fields as all fields will be populated with the first choice.

  gradeEnum g = globals.gradeStringtoEnum(grade);

  var newData = new globals.BadgeData(
    grade: g,
    name: name,
    description: description,
    requirements: requirements,
    photoLocation: photoLocation,
  );

  switch (g) {
    case gradeEnum.DAISY:
      globals.daisyListBadge.add(newData);
      break;
    case gradeEnum.BROWNIE:
      globals.brownieListBadge.add(newData);
      break;
    case gradeEnum.JUNIOR:
      globals.juniorListBadge.add(newData);
      break;
    case gradeEnum.CADETTE:
      globals.cadetteListBadge.add(newData);
      break;
    case gradeEnum.SENIOR:
      globals.seniorListBadge.add(newData);
      break;
    case gradeEnum.AMBASSADOR:
      globals.ambassadorListBadge.add(newData);
      break;
  }
  globals.allListBadge.add(newData);
  //db.writeBadgeList(grade); //this needs to work with HIVE
}

int getBadgeNum(String grade, String name) {
  if (grade == '') return null;
  //all other variables should come from a list the user has to chose, meaning that there is no room for empty fields as all fields will be populated with the first choice.

  gradeEnum g;

  switch (grade)
  {
    case 'DAISY':
    case 'Daisy':
      g  = gradeEnum.DAISY;
      break;
    case 'BROWNIE':
    case 'Brownie':
      g  = gradeEnum.BROWNIE;
      break;
    case 'JUNIOR':
    case 'Junior':
      g  = gradeEnum.JUNIOR;
      break;
    case 'CADETTE':
    case 'Cadette':
      g  = gradeEnum.CADETTE;
      break;
    case 'SENIOR':
    case 'Senior':
      g  = gradeEnum.SENIOR;
      break;
    case 'AMBASSADOR':
    case 'Ambassador':
      g = gradeEnum.AMBASSADOR;
      break;
  }

  //perform query

  return 0;
}

//this function also add the add member card at the end of the list. selectable should mainly be false if you want it to bring up the infromation
List<Widget> getBadgeWidgetList(gradeEnum grade, bool selectable, {Member member}) {
  var returnList = new List<Widget>();
  var gradeList;

  gradeList = globals.getGradeBadges(grade);

  for (var i in gradeList) {
    returnList.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new BadgeCard(grade: i.grade,
              name: i.name,
              selectable: selectable,
              member: member,
              description: i.description,
              requirements: i.requirements,
              quantity: 0,//getBadgeNum(describeEnum(i.grade), i.name),
              photoLocation: i.photoLocation,
              isMemberBadge: false),

        ]));
  }
  return returnList;
}

//this function also add the add member card at the end of the list.

