
//I might also enumerate the months of the year, but idk.
import 'package:flutter/widgets.dart';
import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/models.dart';


GirlScoutDatabase db = GirlScoutDatabase();

var monthNames = [
  '', // ignore first position since months index from 1-12
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

var monthNums = {
  'January': 1,
  'February': 2,
  'March': 3,
  'April': 4,
  'May': 5,
  'June': 6,
  'July': 7,
  'August': 8,
  'September': 9,
  'October': 10,
  'November': 11,
  'December': 12
};
/*
class Data {
  gradeEnum grade;
  String name;
  String team;
  String birthMonth;
  int birthDay;
  int birthYear;
  String photoLocation;

  //NOTES

  Data(
      {this.grade, this.name, this.team, this.birthMonth, this.birthDay, this.birthYear, this.photoLocation});

  Map<String, dynamic> toMap()
  {
    return{
      'name' : name,
      'team' : team,
      'birthMonth' : birthMonth,
      'birthDay' : birthDay,
      'birthYear' : birthYear,
      'photoPath' : photoLocation,
    };
  }
}

class BadgeData {
  gradeEnum grade;
  String name;
  String description;
  List<String> requirements;
  String photoLocation; //idk if we need this

  BadgeData(
      {this.grade, this.name, this.description, this.requirements, this.photoLocation});

  Map<String, dynamic> toMap()
  {
    return{
      'name' : name,
      'description' : description,
      'requirements' : requirements,
      'photoPath' : photoLocation,
    };
  }
}


List<BadgeData> getGradeBadges(gradeEnum grade) {
  var gradeList;

  switch (grade) {
    case gradeEnum.DAISY:
    //add member data as widget
      gradeList =  daisyListBadge;
      break;
    case gradeEnum.BROWNIE:
      gradeList =  brownieListBadge;
      break;
    case gradeEnum.JUNIOR:
      gradeList =  juniorListBadge;
      break;
    case gradeEnum.CADETTE:
      gradeList =  cadetteListBadge;
      break;
    case gradeEnum.SENIOR:
      gradeList =  seniorListBadge;
      break;
    case gradeEnum.AMBASSADOR:
      gradeList = ambassadorListBadge;
      break;
    case gradeEnum.ALL:
      gradeList = allListBadge;
      break;
  }

  return gradeList;
}
*/
gradeEnum gradeStringtoEnum(String grade) {
  var g;

  switch (grade) {
    case 'Daisy':
    case 'DAISY':
      g = gradeEnum.DAISY;
      break;
    case 'Brownie':
    case 'BROWNIE':
      g = gradeEnum.BROWNIE;
      break;
    case 'Junior':
    case 'JUNIOR':
      g = gradeEnum.JUNIOR;
      break;
    case 'Cadette':
    case 'CADETTE':
      g = gradeEnum.CADETTE;
      break;
    case 'Senior':
    case 'SENIOR':
      g = gradeEnum.SENIOR;
      break;
    case 'Ambassador':
    case 'AMBASSADOR':
      g = gradeEnum.AMBASSADOR;
      break;
  }
  return g;

}

/*
int count = 0;
var allList = new List<Data>();
var daisyList = new List<Data>();
var brownieList = new List<Data>();
var juniorList = new List<Data>();
var cadetteList = new List<Data>();
var seniorList = new List<Data>();
var ambassadorList = new List<Data>();

var allListBadge = new List<BadgeData>();
var daisyListBadge = new List<BadgeData>();
var brownieListBadge = new List<BadgeData>();
var juniorListBadge = new List<BadgeData>();
var cadetteListBadge = new List<BadgeData>();
var seniorListBadge = new List<BadgeData>();
var ambassadorListBadge = new List<BadgeData>();

var allListPatch = new List<BadgeData>();
var daisyListPatch = new List<BadgeData>();
var brownieListPatch = new List<BadgeData>();
var juniorListPatch = new List<BadgeData>();
var cadetteListPatch = new List<BadgeData>();
var seniorListPatch = new List<BadgeData>();
var ambassadorListPatch = new List<BadgeData>();

 */