import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
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
  String gradeString;
  final _formKey = GlobalKey<FormState>();

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
      validator: (text) => (text.isEmpty && requirementFields.length == 1 )?
          "Please enter at least one requirement" : null,
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
        child: Form(
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
                      hintText: 'Enter badge\'s name',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) => text.isEmpty ?
                        "Please enter badge's name" : null,
                    controller: nameController,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text("Description", style: Theme
                      .of(context)
                      .textTheme
                      .headline2,),
                  SizedBox(height: 5),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter badge\'s description',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) => text.isEmpty ?
                        "Please enter badge's description" : null,
                    controller: descriptionController,
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
                      "Please choose badge's grade" : null,
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

                  Column (
                    children: requirementFields,
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
                        onPressed: () async {
                          //TODO make it so that pictures are optional
                          //TODO add error messages for unpopulated fields
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

                                final File localFile = await file.copy('$path');

                                print(path);
                                /*
                                addBadgeToList(
                                    gradeString,
                                    nameController.text,
                                    descriptionController.text,
                                    getRequirements(),
                                    path);
                                 */
                                db.addBadge(gradeString,
                                    nameController.text,
                                    descriptionController.text,
                                    getRequirements(),
                                    path);
                                //Navigator.push(context, MaterialPageRoute(builder: (
                                //+context) => Members()));
                                Navigator.pop(context);
                            }
                            else {
                              print('no bacon');
                            }
                          }
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ),
      )
    );
  }
}
