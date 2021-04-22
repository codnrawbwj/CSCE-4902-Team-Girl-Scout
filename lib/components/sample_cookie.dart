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
  String month;
  int day;
  int year;
  var now = DateTime.now();
  //var today = DateTime(now.year, now.month, now.day);

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
                  Text("Today's Date", style: Theme
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
                          "Please enter today's date" : null,
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
                          "Please enter today's date" : null,
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
                          "Please enter today's date" : null,
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
}

