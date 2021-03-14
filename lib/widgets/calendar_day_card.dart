import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDayCard extends StatelessWidget {
  final DateTime day;
  final bool isClicked;
  final int index;
  CalendarDayCard(this.day, {this.isClicked = false, this.index});
 
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
            margin: const EdgeInsets.all(8),
        width: deviceSize.width * .2,
        height: deviceSize.height * .12,
        decoration: BoxDecoration(
          color: isClicked ? Theme.of(context).primaryColor : null,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor, width: 3,),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat.E().format(
                  day,
                ),
                style:
                    Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('dd').format(
                  day,
                ),
                style:
                    Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
    );
  }
}
