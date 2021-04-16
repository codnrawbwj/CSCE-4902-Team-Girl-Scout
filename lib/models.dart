import 'dart:core';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:girl_scout_simple/components/globals.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class Member extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList grade;

  @HiveField(2)
  String team;

  @HiveField(3)
  DateTime birthday;

  @HiveField(4)
  String photoPath;

  @HiveField(5)
  HiveList badgeTags;

  @HiveField(6)
  HiveList seasons;

  @HiveField(7)
  HiveList sales;

  @HiveField(8)
  String isArchived;

  Member(this.name, this.grade, this.team, this.birthday, this.photoPath, this.badgeTags, this.seasons, this.sales, {this.isArchived = 'No'});
}

@HiveType(typeId: 1)
class BadgeTag extends HiveObject{
  @HiveField(0)
  String status;

  @HiveField(1)
  String completedRequirements;

  @HiveField(2)
  DateTime dateAcquired; // should not store the time

  @HiveField(3)
  HiveList badge;

  @HiveField(4)
  HiveList member;

  @HiveField(5)
  Map<String,String> requirementsMet;

  BadgeTag(this.badge, this.member, this.requirementsMet, {this.status = 'Incomplete', this.completedRequirements = 'No'});
  BadgeTag.date(this.dateAcquired);
}

@HiveType(typeId: 2)
class Badge extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String subtitle;

  @HiveField(2)
  String description;

  @HiveField(3)
  HiveList grade;

  @HiveField(4)
  String type;

  @HiveField(5)
  List<String> requirements;

  @HiveField(6)
  String photoPath;

  @HiveField(7)
  HiveList badgeTags;

  @HiveField(8)
  String isArchived;

  Badge(this.name, this.description, this.grade, this.requirements, this.photoPath, this.badgeTags, {this.isArchived = 'No'});
}

@HiveType(typeId: 3)
class Grade extends HiveObject {
  @HiveField(0)
  gradeEnum name;

  @HiveField(1)
  HiveList members;

  @HiveField(2)
  HiveList badges;

  Grade(this.name, this.members, this.badges);
  Grade.name(this.name);
}

@HiveType(typeId: 4)
enum gradeEnum {
  @HiveField(0)
  DAISY,

  @HiveField(1)
  BROWNIE,

  @HiveField(2)
  JUNIOR,

  @HiveField(3)
  CADETTE,

  @HiveField(4)
  SENIOR,

  @HiveField(5)
  AMBASSADOR,

  @HiveField(6)
  ALL,
}

@HiveType(typeId: 5)
class Cookie extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String photoPath;

  @HiveField(4)
  HiveList seasons;

  @HiveField(5)
  HiveList sales;

  @HiveField(6)
  HiveList orders;

  @HiveField(7)
  HiveList transfers;

  @HiveField(8)
  String isArchived;

  Cookie(this.name, this.price, this.quantity, this.photoPath, this.seasons, this.sales, this.orders, this.transfers, {this.isArchived = 'No'});
}

@HiveType(typeId: 6)
class Sale extends HiveObject {
  @HiveField(0)
  int quantity;

  @HiveField(1)
  DateTime dateOfSale;

  @HiveField(2)
  double salesPrice;

  @HiveField(3)
  String typeOfSale;

  @HiveField(4)
  HiveList season;

  @HiveField(5)
  HiveList member;

  @HiveField(6)
  HiveList cookie;

  Sale(this.quantity, this.dateOfSale, this.salesPrice, this.typeOfSale, this.season, this.member, this.cookie);

}

@HiveType(typeId: 7)
class Order extends HiveObject {
  @HiveField(0)
  int quantity;

  @HiveField(1)
  DateTime dateOfSale;

  @HiveField(2)
  HiveList season;

  @HiveField(3)
  HiveList cookie;

  Order(this.quantity, this.dateOfSale, this.season, this.cookie);
}

@HiveType(typeId: 8)
class Transfer extends HiveObject {
  @HiveField(0)
  int quantity;

  @HiveField(1)
  DateTime dateOfTransfer;

  @HiveField(2)
  String receivingTroop;

  @HiveField(3)
  HiveList season;

  @HiveField(4)
  HiveList cookie;

  Transfer(this.quantity, this.dateOfTransfer, this.receivingTroop, this.season, this.cookie);
}

@HiveType(typeId: 9)
class Season extends HiveObject {
  @HiveField(0)
  int year;

  @HiveField(1)
  DateTime startDate;

  @HiveField(2)
  HiveList members;

  @HiveField(3)
  HiveList cookies;

  @HiveField(4)
  HiveList sales;

  @HiveField(5)
  HiveList orders;

  @HiveField(6)
  HiveList transfers;
  
  Season(this.year, this.startDate, this.members, this.cookies, this.sales, this.orders, this.transfers);
}

@HiveType(typeId: 10)
class Cookies extends HiveObject{
  @HiveField(0)
  String cookieName;

  @HiveField(1)
  String amount;

  @HiveField(2)
  String cost;

  Cookies(this.cookieName, this.amount, this.cost);
}