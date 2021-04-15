import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/screens/seasonSetup.dart';
import 'package:girl_scout_simple/components/globals.dart';

import '../models.dart';

class SampleCookie extends StatefulWidget {
  SampleCookie({@required this.title, this.cookie, this.callingObj});
  String title;
  Cookie cookie;
  final dynamic callingObj;

  static String id = '/SampleCookie';
  @override
  _SampleCookieState createState() => _SampleCookieState();
}

class _SampleCookieState extends State<SampleCookie> {

  String name;
  int amount;
  double price;

  final cookieNameController = TextEditingController();
  final amountController = TextEditingController();
  final priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool enableButton;
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
                  Text("Cookie Name", style: Theme
                      .of(context)
                      .textTheme.headline2,),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter type of cookie',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) => text.isEmpty ?
                    "Please enter cookie's type" : null,
                    controller: cookieNameController,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text("Quantity", style: Theme
                      .of(context)
                      .textTheme
                      .headline2,),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter amount to order',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) => text.isEmpty ?
                    "Please enter amount needed" : null,
                    controller: amountController ,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text("Price", style: Theme
                      .of(context)
                      .textTheme
                      .headline2,),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter cost of 1 unit',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kGreenColor),
                      ),
                    ),
                    validator: (text) => text.isEmpty ?
                    "Please enter price" : null,
                    controller: priceController,
                    style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                  ),
                  SizedBox(height: 20),
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
                        onPressed:
                            () async {
                          if(widget.cookie == null) {
                            await db.addCookie(cookieNameController.text, amountController.text, priceController.text);
                          }
                          //add to database

                          Navigator.of(context).pop(
                              MaterialPageRoute(
                                  builder: (context) => SeasonSetup()
                              )
                          );
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
