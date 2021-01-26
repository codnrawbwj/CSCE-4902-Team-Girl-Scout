import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/member_container.dart';
import 'package:girl_scout_simple/components/badge_container.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
//import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/models.dart';

class AddBadge extends StatefulWidget {
  //TODO: complete parameters
  AddBadge({@required this.title, @required this.grade});
  final String title; //(ex) Add Member
  final gradeEnum grade;

  static String id = '/Add';
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddBadge> {

  String name;
  String description;
  String quantity;
  String gradeString = 'Daisy';

  int requirementIndex = 1;
  List<Widget> requirementFields = [];
  List<TextEditingController> requirementTextControllers = [];
  File _image;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

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

  //this will dynamically add text fields as the are populated.
  void addRequirement()
  {

    requirementTextControllers.add(TextEditingController());
    print('added\n');
    requirementFields.add(TextFormField(
      onChanged: (text){
        if (requirementIndex == 1) return;
        if (requirementTextControllers[requirementTextControllers.length - 1].text == '') return;
        else addRequirement();
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Requirement ' + requirementIndex.toString(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kGreenColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kGreenColor),
        ),
      ),
      controller: requirementTextControllers[requirementIndex - 1],
      style: TextStyle(color: kDarkGreyColor, fontSize: 16),
    ));
    ++requirementIndex;
    setState((){});

  }

  //this will remove the empty requirement if there is a filled requirements after it. this will never remove the last requirements which should always be blank.
  void removeRequirements()
  {

  }

  List<String> getRequirements()
  {
    List<String> result = [];
    for (var i in requirementTextControllers) {
        result.add(i.text);
      }
    return result;
  }



  @override
  void initState() {
    addRequirement();
    super.initState();
  }

  //dispose of your text controllers? idk if we need to do this for all objects...
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
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
          "Add Badge", ///USE BOOLEAN TO CHECK IF WE ARE ADDING A BADGE OR PATCH
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
                  hintText: 'Enter a name for the badge',
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
              Text("Description", style: Theme
                  .of(context)
                  .textTheme
                  .headline2,),

              SizedBox(height: 5),
              Column (
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter a description for the badge',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    controller: descriptionController,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                  ),
                  ],
              ),

              SizedBox(height: 20),
              Text("Grade", style: Theme
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
              Text("Requirements", style: Theme
                  .of(context)
                  .textTheme
                  .headline2,),
              SizedBox(height: 5),



              //TODO add requirements dynamically.
              Column (
                children: requirementFields,
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
                      //TODO make it so that pictures are optional
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

                      print(path);
                      addBadgeToList(gradeString, nameController.text, descriptionController.text, getRequirements(), path);
                      await db.addBadge(gradeString, nameController.text, descriptionController.text, getRequirements(), path);
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
