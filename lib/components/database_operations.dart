import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:girl_scout_simple/models.dart';

///HUGE TODO - make the work with our actual local database. I am using our old file system for now so that we can present our apps functionality!!!


class GirlScoutDatabase {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> deleteAllData() async{
  var memberBox = Hive.box('members');
  var badgeBox = Hive.box('badges');
  var badgeTagBox = Hive.box('badgeTags');
  await badgeBox.clear();
  for(Badge b in badgeBox.values) {
    File(b.photoPath).delete();
  }
  await memberBox.clear();
  for(Member m in memberBox.values) {
    File(m.photoPath).delete();
  }
  await badgeTagBox.clear();
/*
  allList.clear();
  daisyList.clear();
  brownieList.clear();
  juniorList.clear();
  cadetteList.clear();
  seniorList.clear();
  ambassadorList.clear();

  allListBadge.clear();
  daisyListBadge.clear();
  brownieListBadge.clear();
  juniorListBadge.clear();
  cadetteListBadge.clear();
  seniorListBadge.clear();
  ambassadorListBadge.clear();

  allListPatch.clear();
  daisyListPatch.clear();
  brownieListPatch.clear();
  juniorListPatch.clear();
  cadetteListPatch.clear();
  seniorListPatch.clear();
  ambassadorListPatch.clear();
*/
  //cant delete other two boxes
}

  Future<void> initDB() async{
    WidgetsFlutterBinding.ensureInitialized();
    final appDBDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDBDirectory.path);

    Hive.registerAdapter(BadgeTagAdapter());
    Hive.registerAdapter(BadgeAdapter());
    Hive.registerAdapter(GradeAdapter());
    Hive.registerAdapter(MemberAdapter());
    Hive.registerAdapter(gradeEnumAdapter());
    Hive.registerAdapter(CookieAdapter());
    Hive.registerAdapter(SaleAdapter());
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(TransferAdapter());
    Hive.registerAdapter(SeasonAdapter());

    await Hive.openBox('members');
    await Hive.openBox('badgeTags');
    await Hive.openBox('grades');
    await Hive.openBox('badges');
    await Hive.openBox('cookies');
    await Hive.openBox('sales');
    await Hive.openBox('orders');
    await Hive.openBox('transfers');
    await Hive.openBox('seasons');

    /*
    var gradeBox = Hive.box('grades');
    var memberBox = Hive.box('members');
    var badgeBox = Hive.box('badges');
    await badgeBox.clear();
    await memberBox.clear();
    await gradeBox.clear();


    print('loading members');
    await db.loadMembers();
    print('loading badges');
    await db.loadBadges();

     */
    print('loading grades');
    await loadGrades();

    imageCache.clear();

    var seasonsBox = Hive.box('seasons');
    if (seasonsBox.get('isStarted') == null) seasonsBox.put('isStarted', false);
  }

  Future<void> loadGrades() async {
    var gradeBox = Hive.box('grades');

    if (gradeBox.isEmpty) {
      var memberBox = Hive.box('members');
      var badgeBox = Hive.box('badges');

      var memberHiveList = HiveList(memberBox); // HiveList to initialize grade's members
      var badgeHiveList = HiveList(badgeBox); // HiveList to initialize grade's badges

      gradeBox.put('Daisy', Grade(gradeEnum.DAISY, memberHiveList, badgeHiveList));
      gradeBox.put('Brownie', Grade(gradeEnum.BROWNIE, memberHiveList, badgeHiveList));
      gradeBox.put('Junior', Grade(gradeEnum.JUNIOR, memberHiveList, badgeHiveList));
      gradeBox.put('Cadette', Grade(gradeEnum.CADETTE, memberHiveList, badgeHiveList));
      gradeBox.put('Senior', Grade(gradeEnum.SENIOR, memberHiveList, badgeHiveList));
      gradeBox.put('Ambassador', Grade(gradeEnum.AMBASSADOR, memberHiveList, badgeHiveList));
    }
  }
/*
  Future<void> loadMembers() async{
    try {
      var memberBox = Hive.box('members');

      for (var i in memberBox.values)
        {
          print(i.name);
          Grade grade = i.grade.first;
          addScoutToList(describeEnum(grade.name), i.team, i.name, monthNames[i.birthday.month], i.birthday.day, i.birthday.year, i.photoPath);
        }
    }
    catch (e) {
      print("Load member failed");
      return;
    }
  }
*/
  Future<void> addMember (String grade, String team, String name, String birthMonth, int birthDay, int birthYear, String photoPath) async{
    //try {
    print('adding member');
      var memberBox = Hive.box('members'); //open boxes
      var gradeBox = Hive.box('grades');
      var badgeTagBox = Hive.box('badgeTags');

      var gradeLink = HiveList(gradeBox); // create a hive list to hold 1 grade
      print(gradeBox.get(grade));
      gradeLink.add(gradeBox.get(grade)); // add the member's grade to the list

      var badgeTagHiveList = HiveList(badgeTagBox); // HiveList to initialize member's BadgeTags

      var date = DateTime(birthYear, monthNums[birthMonth], birthDay); // create a datetime object from string inputs
      Member member = Member(name, gradeLink, team, date, photoPath, badgeTagHiveList); // create member object based on data
      memberBox.put(name, member); // add member to db

      Grade gradeObj = gradeBox.get(grade); // get grade from db
      gradeObj.members.add(member); // add member to grade
      gradeObj.save();
      /*
    }
    catch (e) {
      print(e);
      print("Add member failed");
      return;
    }

       */
  }

  Future<void> editMember (Member member, String grade, String team, String name, String birthMonth, int birthDay, int birthYear, String photoPath) async{
    //try {
    print('editing member');
    var memberBox = Hive.box('members'); //open boxes
    var gradeBox = Hive.box('grades');
    var newGrade = gradeBox.get(grade);
    var gradeLink;

    if(member.grade.first != newGrade){ //if grade changed, remove member from old grade and add member to new grade
        Grade oldGrade = member.grade.first;
        oldGrade.members.remove(member); // remove member from old grade
        oldGrade.save();

        gradeLink = HiveList(gradeBox); // create a hive list to hold 1 grade
        print(grade);
        gradeLink.add(newGrade); // add the member's grade to the list

        member.grade = gradeLink; //link grade to member

        Grade gradeObj = gradeBox.get(grade); // get new grade from db
        gradeObj.members.add(member); // add member to grade
        gradeObj.save();
    }

    member.name = name;
    member.team = team;
    member.birthday = DateTime(birthYear, monthNums[birthMonth], birthDay);

    if(member.photoPath != photoPath) { // if the photo is changed
        File(member.photoPath).delete(); // delete old photo
        member.photoPath = photoPath; //set new photo
    }

    member.save();
  }


  Member getMember (String name) {
    //try {
    print('getting member');
    var memberBox = Hive.box('members'); //open member box

    Member member = memberBox.get(name); // get member
    return member;
    /*
    }
    catch (e) {
      print(e);
      print("Add member failed");
      return;
    }

       */
  }

  List<dynamic> getMembersByGrade(gradeEnum gradeE) {
    var gradeBox = Hive.box('grades');
    var memberBox = Hive.box('members');
    Grade grade;
    HiveList gradeMembersList;

    String gradeString = describeEnum(gradeE);
    gradeString = gradeString[0] + gradeString.substring(1).toLowerCase();
    print(gradeString);

    if(gradeString == 'All') {
      gradeMembersList = HiveList(memberBox);
      for(grade in gradeBox.values) {
        gradeMembersList.addAll(grade.members);
      }
    }
    else {
      grade = gradeBox.get(gradeString);
      gradeMembersList = grade.members;
    }
    print(gradeMembersList.length);
    return gradeMembersList.toList();
  }

  int getMemberCount () {
    var memberBox = Hive.box('members');
    return memberBox.length;
  }

  Future<void> deleteMember(String grade, String team, String name, String birthMonth, int birthDay, int birthYear, String photoPath) async{
    return;
  }
/*
  Future<void> loadBadges() async {
    try {
      var badgeBox = Hive.box('badges');

      for (var i in badgeBox.values)
      {
        Grade grade = i.grade.first;
        addBadgeToList(describeEnum(grade.name), i.name, i.description, i.requirements, i.photoPath);
      }
    } catch (e) {
      print("Load failed");
      return;
    }
  }

 */

  void addBadge(String grade, String name, String description, List<String> requirements, String photoLocation) {
    try {
      var badgeBox = Hive.box('badges'); //open boxes
      var gradeBox = Hive.box('grades');
      var badgeTagBox = Hive.box('badgeTags');

      var gradeLink = HiveList(gradeBox); // create a hive list of grades
      gradeLink.add(gradeBox.get(grade)); // add the member's grade to the list

      var badgeTagLink = HiveList(badgeTagBox); // HiveList to initialize badge's BadgeTags

      Badge badge = Badge(name, description, gradeLink, requirements, photoLocation, badgeTagLink); // create member object based on data
      badgeBox.add(badge); // add member to db

      Grade gradeObj = gradeBox.get(grade); // get grade from db
      gradeObj.badges.add(badge); // add member to grades
      gradeObj.save();

    }
    catch (e) {
      print("Add member failed");
      return;
    }
  }

  Future<void> addCookie (String cookie, String amount, String price) async{
    //try {
    print('adding cookie');
    var cookieBox = Hive.box('cookie'); //open boxes
    var amountBox = Hive.box('amount');
    var priceTagBox = Hive.box('price');

    var cookieLink = HiveList(cookieBox); // create a hive list to hold 1 grade
    print(cookieBox.get(cookie));
    cookieLink.add(cookieBox.get(cookie)); // add the member's grade to the list

    Cookies cookies = Cookies(cookie, amount, price);
    priceTagBox.add(cookies);

    var priceTagHiveList = HiveList(priceTagBox); // HiveList to initialize member's BadgeTags
    /*
    }
    catch (e) {
      print(e);
      print("Add member failed");
      return;
    }

       */
  }

  Badge getBadge(String name)
  {
    print('getting badge');
    var badgeBox = Hive.box('badges'); //open member box
    Badge i;
    for (i in badgeBox.values) {
      if (i.name == name) break;
    }



    //Badge badge = badgeBox.get('cyc'); // get member
    return i;

  }

  List<dynamic> getBadgesByGrade(gradeEnum gradeE) {
    var badgeBox = Hive.box('badges');
    var gradeBox = Hive.box('grades');
    Grade grade;
    HiveList gradeBadgesList;

    String gradeString = describeEnum(gradeE);
    gradeString = gradeString[0] + gradeString.substring(1).toLowerCase();
    print(gradeString);

    if(gradeString == 'All') {
      gradeBadgesList = HiveList(badgeBox);
      for(grade in gradeBox.values) {
        gradeBadgesList.addAll(grade.badges);
      }
    }
    else {
      grade = gradeBox.get(gradeString);
      gradeBadgesList = grade.badges;
    }
    print(gradeBadgesList.length);
    return gradeBadgesList.toList();
  }

  int getBadgeCount () {
    var badgeBox = Hive.box('badges');
    return badgeBox.length;
  }

  dynamic addBadgeTag (Member member, Badge badge) {
    //try {
    print('adding member badge');
    var memberBox = Hive.box('members'); //open boxes
    var badgeBox = Hive.box('badges');
    var badgeTagBox = Hive.box('badgeTags');

    Map<String,String> requirementsMet = Map();

    for (BadgeTag bt in member.badgeTags) { // check if member already has badge
      Badge b = bt.badge.first;
      if (b.name == badge.name ) {
        return null; // return empty
      }
    }

    var badgeLink = HiveList(badgeBox); // create a hive list to hold 1 badge
    badgeLink.add(badge); // link badge to badgeTag

    var memberLink = HiveList(memberBox); // create a hive list to hold 1 member
    memberLink.add(member); // link member to badgeTag

    for (var i in badge.requirements) { // for each badge requirement
      if (i != "") requirementsMet[i] = "No"; // mark incomplete
    }


    BadgeTag badgeTag = BadgeTag(badgeLink, memberLink, requirementsMet); // create badgeTag

    badgeTagBox.add(badgeTag); // add badgeTag to db

    /*
    for (var i in badgeTagBox.values) {
      print('badge tag box values');
      print(i.status);
    }
  */

    badge.badgeTags.add(badgeTag); // link badgeTag to badge
    member.badgeTags.add(badgeTag); // link badgeTag to member
    member.save();
    badge.save();
    return 1;
    /*
    BadgeTag memberbadge = member.badgeTags.first;
    print(memberbadge.status);
    */

    /*
    }
    catch (e) {
      print(e);
      print("Add member failed");
      return;
    }

       */
  }

  List<dynamic> getMemberBadges (String name) {
    //try {
    print('getting member\'s badges');

    var badgeTagBox = Hive.box('badgeTags');

    Member member = getMember(name); //get member
    HiveList memberBadges = member.badgeTags; // get member's badges
    print(memberBadges);
    if (memberBadges != null) { // if member has badges, return them
      print('returning member\'s badges');
      return memberBadges.toList();
    }
    print('member has no badges');
    return null; // return null if no badges

    /*
    }
    catch (e) {
      print(e);
      print("Add member failed");
      return;
    }

       */
  }


  List<dynamic> getUndistributedMemberBadges() {
    //try {
    print('getting undistributed member\'s badges');

    var badgeTagBox = Hive.box('badgeTags');

    var undistributedBadges = badgeTagBox.values.where((badge) =>
    (badge.status == 'Awaiting Badge'));

    if (undistributedBadges != null) { // if member has badges, return them
      print('returning undistributed member\'s badges');
      return undistributedBadges.toList();
    }
    print('No undistributed badges');
    return null; // return null if no badges

    /*
    }
    catch (e) {
      print(e);
      print("Add member failed");
      return;
    }

       */
  }

  List<dynamic> getCookieRestock() {
    //try {
    print('getting cookie restock');

    var cookieBox = Hive.box('cookies');
    var cookieRestock = cookieBox.values;
    /*
    var undistributedBadges = badgeTagBox.values.where((badge) =>
    (badge.status == 'Awaiting Badge'));

    if (undistributedBadges != null) { // if member has badges, return them
      print('returning undistributed member\'s badges');
      return undistributedBadges.toList();
    }
    */
    print('No cookies to restock');
    return cookieRestock.toList(); // return null if no
  }



  void startSeason () {
    var seasonBox = Hive.box('seasons');

    seasonBox.put('isStarted', true);
  }

  void endSeason () {
    var seasonBox = Hive.box('seasons');

    seasonBox.put('isStarted', false);
  }


  bool isSeasonStarted() {
    var seasonBox = Hive.box('seasons');

    return seasonBox.get('isStarted');
  }



}