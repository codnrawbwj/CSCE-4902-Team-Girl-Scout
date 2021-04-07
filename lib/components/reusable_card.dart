import 'package:flutter/material.dart';
import 'package:girl_scout_simple/models.dart';
import 'package:girl_scout_simple/components/constants.dart';
import 'package:girl_scout_simple/screens/addEditMember.dart';
import 'package:girl_scout_simple/screens/addEditBadge.dart';
import 'package:girl_scout_simple/screens/badgeList.dart';
import 'package:girl_scout_simple/components/globals.dart';
import 'package:girl_scout_simple/components/default_theme.dart';


class ReusableCard extends StatelessWidget {

  ReusableCard({this.parentPage, this.title, this.subtitle, @required this.addIcon, @required this.cardChild, this.member, this.callingObj});
  final String parentPage;
  final String title;
  final String subtitle;
  final Widget cardChild;
  final bool addIcon;
  final Member member;
  final dynamic callingObj;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: DefaultTheme.lightTheme,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            // color: kLightGreyColor,
            color: kLightGreenColor
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              parentPage == 'Setting' ? ExcludeTitle() : IncludeTitle(title: title, subtitle: subtitle, addIcon: addIcon, member: member, callingObj: callingObj),
              //show only if subtitle is not null ('')
              subtitle == '' ? SizedBox(height: 0.0) : SizedBox(height: 10.0),
              subtitle == '' ? SizedBox() : Text(subtitle, style: Theme.of(context).textTheme.bodyText2),
              subtitle == '' ? SizedBox(height: 0.0) : SizedBox(height: 15.0),
              cardChild,
            ],
          ),
        ),
      ),
    );
  }
}

class ExcludeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class IncludeTitle extends StatefulWidget {

  IncludeTitle({@required this.title, @required this.subtitle, @required this.addIcon, this.member, this.callingObj});
  final String title;
  final String subtitle;
  final bool addIcon;
  final Member member;
  final dynamic callingObj;

  @override
  _IncludeTitleState createState() => _IncludeTitleState();
}

class _IncludeTitleState extends State<IncludeTitle> {
  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline2,
          ),
          //Note: Place empty container if add icon is not needed.
          widget.addIcon == false ? Container() :
          GestureDetector( onTap: ()  {
            //move to add
            //TODO: Figure out why this is not working >>>>>> Navigator.pushNamed(context, Add.id);
            (widget.title == 'Badges') ? Navigator.push(context, MaterialPageRoute(builder: (context) =>  new AddEditBadge(title: 'Add Badge'))) :
            (widget.title == 'Patches') ? Navigator.push(context, MaterialPageRoute(builder: (context) =>  new AddEditBadge(title: 'Add Patch'))) :
            (widget.title == 'Scout\'s Badges') ?  Navigator.push(context, MaterialPageRoute(builder: (context) =>  new BadgeListPage(type: 0, member: widget.member)))
                .then((value) => widget.callingObj.refresh()) :
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  new AddEditMember(title: 'Add Member')));
          }, child: Icon(Icons.add_circle), ),
        ],
      );
  }
}
