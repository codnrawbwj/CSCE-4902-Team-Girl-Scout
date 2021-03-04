import 'package:flutter/material.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/screens/addEditMember.dart';

class AnimatedAddCard extends StatefulWidget {
  @override
  _AnimatedAddCard createState() => _AnimatedAddCard();
}

class _AnimatedAddCard extends State<AnimatedAddCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        color: kGreenColor,
        border: Border.all(
          color: kLightGreyColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      duration: Duration(milliseconds: 100),

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(onTap: () {
                  //I used this because im not sure how to just place buttons in the middle of the control. ill figure it out later. im tired.-
                }, child: Icon(Icons.add, color: kWhiteColor,),),
              ]
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Add(title: 'Add Member')));
          },
        ),
      ),
    );
  }
}



