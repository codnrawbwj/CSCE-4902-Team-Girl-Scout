
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
