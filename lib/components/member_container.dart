//Hopefully this file will contain all data for members and return a list of widgets
//I am not sure that this is acceptable, but i believe that having all members accessable at a global level is optimal for our program to function efficiently.
//this file contains 8 lists and a couple functions for placing scouts into those lists based on thier level.abstract
//return funtion of this file returns a list of rows, each holding a member and an edit widget. pretty neat right? flutter is great!
import 'dart:io';

//import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/components/member_card.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:flutter/widgets.dart';
import 'package:girl_scout_simple/models.dart';

//returns 0 if scout is placed in a list, this can be used my the add_member_card to verify that all fields are filled out
void addScoutToList(String grade, String team, String name, String birthMonth, int birthDay, int birthYear, String photoLocation) {
  if (name == '') return null;
  //all other variables should come from a list the user has to chose, meaning that there is no room for empty fields as all fields will be populated with the first choice.

  gradeEnum g = globals.gradeStringtoEnum(grade);

  var newData = new Data(
    grade: g,
    name: name,
    team: team,
    birthMonth: birthMonth,
    birthDay: birthDay,
    birthYear: birthYear,
    photoLocation: photoLocation,
  );

  switch (g) {
    case gradeEnum.DAISY:
      globals.daisyList.add(newData);
      break;
    case gradeEnum.BROWNIE:
      globals.brownieList.add(newData);
      break;
    case gradeEnum.JUNIOR:
      globals.juniorList.add(newData);
      break;
    case gradeEnum.CADETTE:
      globals.cadetteList.add(newData);
      break;
    case gradeEnum.SENIOR:
      globals.seniorList.add(newData);
      break;
    case gradeEnum.AMBASSADOR:
      globals.ambassadorList.add(newData);
      break;
  }
  globals.allList.add(newData);

  //db.writeMemberList(grade);
}
/*
void deleteMember(gradeEnum grade, Data data)
{
  GirlScoutDatabase db = GirlScoutDatabase();

  switch (grade)
  {
    case gradeEnum.DAISY:
      globals.daisyList.remove(data);
      break;
    case gradeEnum.BROWNIE:
      globals.brownieList.remove(data);
      break;
    case gradeEnum.JUNIOR:
      globals.juniorList.remove(data);
      break;
    case gradeEnum.CADETTE:
      globals.cadetteList.remove(data);
      break;
    case gradeEnum.SENIOR:
      globals.seniorList.remove(data);
      break;
    case gradeEnum.AMBASSADOR:
      globals.ambassadorList.remove(data);
      break;
  }
  globals.allList.remove(data);
  final dir = Directory(data.photoLocation);
  dir.delete(recursive:true); //maybe change to false
  db.writeMemberList(grade);
}

 */

//this function also add the add member card at the end of the list.
List<Widget> getMemberWidgetList(gradeEnum grade) {
  var returnList = new List<Widget>();

  switch (grade) {
    case gradeEnum.DAISY:
    //add member data as widget
      for (var i in globals.daisyList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
    case gradeEnum.BROWNIE:
      for (var i in globals.brownieList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
    case gradeEnum.JUNIOR:
      for (var i in globals.juniorList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
    case gradeEnum.CADETTE:
      for (var i in globals.cadetteList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
    case gradeEnum.SENIOR:
      for (var i in globals.seniorList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
    case gradeEnum.AMBASSADOR:
      for (var i in globals.ambassadorList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
    case gradeEnum.ALL:
      for (var i in globals.allList) {
        returnList.add(new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new AnimatedMemberCard(data: i),
            ]));
      }
      break;
  }
  return returnList;
}
