import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/member_container.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/database_operations.dart';

class Add extends StatefulWidget {
  //TODO: complete parameters
  Add({@required this.title});
  String title; //(ex) Add Member

  static String id = '/Add';
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  String name;
  String team;
  String gradeString;
  String month;
  int day;
  int year;
  File _image;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final teamController = TextEditingController();
  final picker = ImagePicker();
  final cropKey = GlobalKey<ImgCropState>();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //dispose of your text controllers? idk if we need to do this for all objects...
  @override
  void dispose() {
    nameController.dispose();
    teamController.dispose();
    super.dispose();
  }

  List<int> getDays() {
    List<int> days;

    days = <int>[for(var i = 1; i <= 28; i++) i];
    if(month != 'February'){
      days.addAll(<int>[29, 30]);
    }
    if(month == 'January' || month == 'March' ||
        month == 'May' || month == 'July' ||
        month == 'August' || month == 'October' ||
        month == 'December') {
      days.add(31);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: kWhiteColor, //change your color here
        ),
        title: Text(
          "Add Member",
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: kDarkGreyColor,),
      body: SingleChildScrollView(
          child: Form (
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Text("Name", style: Theme
                              .of(context)
                              .textTheme
                              .headline2,),
                          SizedBox(height: 5),
                          TextFormField( //name
                              decoration: InputDecoration(
                                  hintText: 'Enter a name',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kGreenColor),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kGreenColor),
                                  ),
                              ),
                              validator: (text) => text.isEmpty ?
                                  "Please enter scout's name" : null,
                              controller: nameController,
                              style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                              ),
                          SizedBox(height: 10),
                          Text("Team", style: Theme
                              .of(context)
                              .textTheme
                              .headline2,),
                          SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter team name',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenColor),
                              ),
                            ),
                            validator: (text) => text.isEmpty ?
                                "Please enter scout's team name" : null,
                            controller: teamController,
                            style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text("Grade", style: Theme
                              .of(context)
                              .textTheme
                              .headline2,),
                          SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: gradeString,
                            hint: Text('Choose Grade'),
                            elevation: 10,
                            style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                            onChanged: (String newValue) {
                              setState(() {
                                gradeString = newValue;
                              });
                            },
                            validator: (choice) => choice == null ?
                                "Please choose scout's grade" : null,
                            items: <String>[
                              'Daisy',
                              'Brownie',
                              'Junior',
                              'Cadette',
                              'Senior',
                              'Ambassador'
                            ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                          Text("Birthday", style: Theme
                              .of(context)
                              .textTheme
                              .headline2,),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.3,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: month,
                                  hint: Text('month'),
                                  elevation: 10,
                                  style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      month = newValue;
                                    });
                                  },
                                  validator: (choice) => choice == null ?
                                      "Please choose scout's birth month" : null,
                                  items: <String>[
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
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.2,
                                child: DropdownButtonFormField<int>(
                                  isExpanded: true,
                                  value: day,
                                  hint: Text('day'),
                                  elevation: 10,
                                  style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                                  onChanged: (int newValue) {
                                    setState(() {
                                      day = newValue;
                                    });
                                  },
                                  validator: (choice) => choice == null ?
                                      "Please choose scout's birth day" : null,
                                  items: getDays().map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.3,
                                child: DropdownButtonFormField<int>(
                                  isExpanded: true,
                                  value: year,
                                  hint: Text('year'),
                                  elevation: 10,
                                  style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                                  onChanged: (int newValue) {
                                    setState(() {
                                      year = newValue;
                                    });
                                  },
                                  validator: (choice) => choice == null ?
                                      "Please choose scout's birth year" : null,
                                  items:
                                      <int>[
                                        for(var i=now.year-19; i<=now.year-7; i++) i
                                      ].map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      getImage(ImageSource.camera);
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.black12,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(8.0),
                                        )
                                    ),
                                    child: Icon(Icons.camera_alt, size: 120.0,)
                                ),
                                SizedBox(width: 15),
                                TextButton(
                                  onPressed: () {
                                    getImage(ImageSource.gallery);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(8.0),
                                      )
                                  ),
                                  child : Icon(Icons.folder, size: 120.0,),
                                ),
                              ]
                          ),
                          Column(
                              children: <Widget>[
                                SizedBox(
                                    width: _image == null ? 1 : 250,
                                    height: _image == null ? 1 : 250,
                                    child: _image == null ? SizedBox(width: 1) : ImgCrop(
                                        image: FileImage(_image),
                                        key: cropKey,
                                        chipShape: 'circle'
                                    )
                                )
                              ]
                          ),
                          SizedBox(height: 20),
                          //TODO: save button
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Save", style: TextStyle(fontSize: 25.0),),
                                ),
                                textColor: kWhiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                ),
                                color: kGreenColor,
                                onPressed: () async
                                {
                                  if(_formKey.currentState.validate()) {
                                      final crop = cropKey.currentState;
                                      final file = await crop.cropCompleted(
                                          _image, pictureQuality: 800
                                      );
                                      final directory = await getApplicationDocumentsDirectory();
                                      String name = file.path;
                                      List<String> fileName = name.split('/');
                                      String path = directory.path;
                                      path += '/' + fileName[fileName.length - 1];

                                      final File localFile = await file.copy(
                                          '$path');

                                      addScoutToList(
                                          gradeString,
                                          teamController.text,
                                          nameController.text,
                                          month,
                                          day,
                                          year,
                                          path);
                                      await db.addMember(
                                          gradeString,
                                          teamController.text,
                                          nameController.text,
                                          month,
                                          day,
                                          year,
                                          path);
                                      //Navigator.push(context, MaterialPageRoute(builder: (
                                      //+context) => Members()));
                                      Navigator.pop(context);
                                  }
                                  else {
                                    print('no bacon');
                                  }
                                },
                              ),
                            ),
                          ),
                      ],
                  ),
              ),
          )
      ),
    );
  }
}
