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

  Member(this.name, this.grade, this.team, this.birthday, this.photoPath, this.badgeTags);
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

  BadgeTag(this.badge, this.member, this.requirementsMet, {this.status = 'Incomplete', this.completedRequirements = 'no'});
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

  Badge(this.name, this.description, this.grade, this.requirements, this.photoPath, this.badgeTags);
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