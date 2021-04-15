import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/screens/members.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:girl_scout_simple/components/globals.dart' as globals;
import 'package:girl_scout_simple/components/database_operations.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:flutter/foundation.dart';
import 'package:girl_scout_simple/components/constants.dart';


class RecordSale extends StatefulWidget {
  //TODO: complete parameters
  RecordSale({this.callingObj});
  final dynamic callingObj;

  static String id = '/RecordSale';
  @override
  _RecordSaleState createState() => _RecordSaleState();
}

class _RecordSaleState extends State<RecordSale> {

  String cookie;
  String  quantity;
  DateTime date;
  String typeOfSale;
  String member;
  Map<String, Cookie> cookies;
  Map<String, Member> members;
  File _image;
  final _formKey = GlobalKey<FormState>();

  final quantityController = TextEditingController();
  final picker = ImagePicker();
  final cropKey = GlobalKey<ImgCropState>();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    print(pickedFile);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void initState() {
    super.initState();
    cookies = {for (var c in db.getCookies()) c.name: c};
    members = {for (var m in db.getMembers()) m.name: m};
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();
    var oneYearAgo = now.subtract(const Duration(days: 365));

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(

          iconTheme: IconThemeData(
            color: kWhiteColor, //change your color here
          ),
          title: Text(
            'Record Sale',
            style: Theme.of(context).textTheme.headline3
          ),
          backgroundColor: Theme.of(context).primaryColor,),
        body: SingleChildScrollView(
            child: Form (
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    //---------------------------Cookie------------------------------

                    Text("Cookie", style: Theme
                        .of(context)
                        .textTheme
                        .headline2,),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: cookie,
                      hint: Text('Choose Cookie'),
                      elevation: 10,
                      style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                      onChanged: (String newValue) {
                        setState(() {
                          cookie = newValue;
                        });
                      },
                      validator: (choice) => choice == null ?
                      "Please choose cookie" : null,
                      items: cookies.keys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),

                    //---------------------------Quantity----------------------------

                    Text("Quantity", style: Theme
                        .of(context)
                        .textTheme
                        .headline2,),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Quantity Sold',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGreenColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGreenColor),
                        ),
                      ),
                      validator: (text) =>
                          text.isEmpty ? "Please enter quantity sold" :
                          int.tryParse(text) == null ? "Please enter a valid number": null,
                      controller: quantityController ,
                      style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                    ),
                    SizedBox(height: 10),

                    //---------------------------Date--------------------------------

                    Text("Date of Sale", style: Theme
                        .of(context)
                        .textTheme
                        .headline2,),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                          TextButton.icon(
                              label: Text('Select Date'),
                              icon: Icon(Icons.calendar_today),
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: kGreenColor,
                                  shadowColor: Colors.black,
                                  elevation: 7
                              ),
                              onPressed: () async{
                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: now,
                                      firstDate: oneYearAgo,
                                      lastDate: now);
                                  setState(() {}); // update displayed date
                              }
                          ),
                          SizedBox(width: 10),
                          date != null ?
                          Text(monthNames[date.month] + ' ' + date.day.toString() + ', ' + date.year.toString()) : null
                      ]),
                    SizedBox(height: 10),

                    //---------------------------Type of Sale------------------------

                    Text("Type of Sale", style: Theme
                        .of(context)
                        .textTheme
                        .headline2,),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: typeOfSale,
                      hint: Text('Choose Type of Sale'),
                      elevation: 10,
                      style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                      onChanged: (String newValue) {
                        setState(() {
                          typeOfSale = newValue;
                        });
                      },
                      validator: (choice) => choice == null ?
                      "Please choose type of sale" : null,
                      items: <String>[
                        'Online',
                        'On-hand'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),

                    //---------------------------Member------------------------------

                    Text("Member", style: Theme
                        .of(context)
                        .textTheme
                        .headline2,),
                    SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: member,
                      hint: Text('Choose Member'),
                      elevation: 10,
                      style: TextStyle(fontSize: 16, color: kDarkGreyColor),
                      onChanged: (String newValue) {
                        setState(() {
                          member = newValue;
                        });
                      },
                      validator: (choice) => choice == null ?
                      "Please choose member" : null,
                      items: members.keys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),

                    //---------------------------Choose Image------------------------

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

                    //---------------------------Image-------------------------------

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

                    //---------------------------Submit------------------------------

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
                                if(_formKey.currentState.validate()) {
                                  /*
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


                                   */

                                    Navigator.pop(context);
                                }
                                else { // form invalid
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