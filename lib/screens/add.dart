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
  String gradeString = 'Daisy';
  String month = 'January';
  int day = 1;
  int year = 2002;
  File _image;

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

  @override
  Widget build(BuildContext context) {
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
              TextField( //name
                decoration: InputDecoration(
                  hintText: 'Enter a name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreenColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreenColor),
                  ),
                ),
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
                controller: teamController,
                style: TextStyle(color: kDarkGreyColor, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text("Level", style: Theme
                  .of(context)
                  .textTheme
                  .headline2,),
              SizedBox(height: 5),
              DropdownButton<String>(
                isExpanded: true,
                value: gradeString,
                elevation: 10,
                style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                underline: Container(
                  height: 1,
                  color: kGreenColor,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    gradeString = newValue;
                  });
                },
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
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: month,
                      elevation: 10,
                      style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                      underline: Container(
                        height: 1,
                        color: kGreenColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          month = newValue;
                        });
                      },
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
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: day,
                      elevation: 10,
                      style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                      underline: Container(
                        height: 1,
                        color: kGreenColor,
                      ),
                      onChanged: (int newValue) {
                        setState(() {
                          day = newValue;
                        });
                      },
                      items: <int>[
                        1,
                        2,
                        3,
                        4,
                        5,
                        6,
                        7,
                        8,
                        9,
                        10,
                        11,
                        12,
                        13,
                        14,
                        15,
                        16,
                        17,
                        18,
                        19,
                        19,
                        20,
                        21,
                        22,
                        23,
                        24,
                        25,
                        26,
                        27,
                        28,
                        month != 'February' ? 29 : null,
                        month != 'February' ? 30 : null,
                        month == 'January' || month == 'March' ||
                            month == 'May' || month == 'July' || month ==
                            'August' || month == 'October' ||
                            month == 'December' ? 31 : null
                      ].map<DropdownMenuItem<int>>((int value) {
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
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: year,
                      elevation: 10,
                      style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                      underline: Container(
                        height: 1,
                        color: kGreenColor,
                      ),
                      onChanged: (int newValue) {
                        setState(() {
                          year = newValue;
                        });
                      },
                      items: <int>[
                        2002,
                        2003,
                        2004,
                        2005,
                        2006,
                        2007,
                        2008,
                        2009,
                        2010,
                        2011,
                        2012,
                        2013,
                        2014,
                        2015,
                        2016,
                        2017,
                        2018,
                        2019,
                        2020,
                        2021,
                        2022,
                        2023,
                        2024,
                        2025
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
                    Expanded(
                        flex: 3,
                        child: Column(
                            children: <Widget>[
                              FlatButton(
                                //TODO: include onPressed functionality
                                onPressed: () {
                                  getImage(ImageSource.camera);
                                },
                                color: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.all(20.0),
                                child: Column( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(Icons.camera_alt, size: 60.0,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              FlatButton(
                                //TODO: include onPressed functionality
                                onPressed: () {
                                  getImage(ImageSource.gallery);
                                },
                                color: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.all(20.0),
                                child: Column( // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(Icons.folder, size: 60.0,)
                                  ],
                                ),
                              ),
                            ]
                        )
                    ),
                    Expanded(
                      flex: 7,
                      child: SizedBox(
                        height: 250,
                          child: _image == null ? SizedBox(height: 1) : ImgCrop(
                            image: FileImage(_image),
                            key: cropKey,
                            chipShape: 'circle'
                      )
                      )
                    )
                  ]
              ),


              /*
              Text("Checklist", style: Theme
                  .of(context)
                  .textTheme
                  .headline2,),
              //TODO: add checklist < for what?

              CheckboxListTile(
                title: const Text('Animate Slowly'),
                value: timeDilation != 1.0,
                onChanged: (bool value) {
                  setState(() {
                    //timeDilation = value ? 10.0 : 1.0;
                  });
                },
                secondary: const Icon(Icons.hourglass_empty),
              ),
//              new CheckboxListTile(
//                title: Text("Add"),
//                activeColor: kDarkGreyColor,
//                checkColor: kWhiteColor,
//                controlAffinity:
//                  ListTileControlAffinity.leading,
//                value: _checked,
//                onChanged: (bool value) {
//                setState(() {
//                timeDilation = value ? 10.0 : 1.0;
//                }),
//              ),
               */
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
                      //TODO add error messages for unpopulated fields
                      final crop = cropKey.currentState;
                      final file = await crop.cropCompleted(
                         _image, pictureQuality: 800
                      );
                      final directory = await getApplicationDocumentsDirectory();
                      String name = file.path;
                      List<String> fileName = name.split('/');
                      String path = directory.path;
                      path += '/' + fileName[fileName.length - 1];

                      final File localFile = await file.copy('$path');

                      addScoutToList(gradeString, teamController.text, nameController.text, month, day, year, path);
                      await db.addMember(gradeString, teamController.text, nameController.text, month, day, year, path);
                      //Navigator.push(context, MaterialPageRoute(builder: (
                          //+context) => Members()));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
