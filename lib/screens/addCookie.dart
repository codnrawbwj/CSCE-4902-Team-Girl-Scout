import 'dart:io';
import 'package:moneytextformfield/moneytextformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/screens/seasonSetup.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:path_provider/path_provider.dart';


import 'package:girl_scout_simple/models.dart';


class AddCookie extends StatefulWidget {
  AddCookie({@required this.title, this.cookie, this.callingObj});
  String title;
  Cookie cookie;
  final dynamic callingObj;

  static String id = '/SampleCookie';
  @override
  _AddCookieState createState() => _AddCookieState();
}

class _AddCookieState extends State<AddCookie> {

  String name;
  int amount;
  double price;
  File _image;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final picker = ImagePicker();
  final cropKey = GlobalKey<ImgCropState>();

  bool enableButton;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kWhiteColor,
        ),
        title: Text('Add Cookie'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  //---------------------------Name--------------------------------

                  Text("Name", style: Theme
                      .of(context)
                      .textTheme.headline2,),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter name of cookie',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) => text.isEmpty ?
                    "Please enter cookie's name" : null,
                    controller: nameController,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
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
                      hintText: 'Enter quantity on hand',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) =>
                        text.isEmpty ? "Please enter the amount on hand" :
                        int.tryParse(text) == null ? "Please enter a valid number": null,
                    controller: quantityController ,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  //---------------------------Price-------------------------------

                  Text("Price", style: Theme
                      .of(context)
                      .textTheme
                      .headline2,),
                  SizedBox(height: 5),
                  MoneyTextFormField(
                    settings: MoneyTextFormFieldSettings(
                        controller: priceController,
                        validator: (text) => text.isEmpty ?
                            "Please enter price" : null,
                        appearanceSettings: AppearanceSettings(
                            labelText: null,
                            inputStyle: TextStyle(color: kDarkGreyColor, fontSize: 16),
                            //formattedStyle: ,
                            hintText: 'Enter cost of one unit',
                        )

                    )
                    /*
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),

                     */

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
                                String path;
                                print('saving photo');
                                final crop = cropKey.currentState;
                                final file = await crop.cropCompleted(
                                    _image, pictureQuality: 800
                                );
                                final directory = await getApplicationDocumentsDirectory();
                                String name = file.path;
                                List<String> fileName = name.split('/');
                                path = directory.path;
                                path += '/' + fileName[fileName.length - 1];
                                final File localFile = await file.copy(
                                    '$path');

                                await db.addCookie(nameController.text,
                                                  int.parse(quantityController.text),
                                                  double.parse(priceController.text),
                                                  path
                                );

                                Navigator.pop(context);
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
