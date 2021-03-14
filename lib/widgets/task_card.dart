import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final int index;
  final Function completionFunc;
  final Function removalFunc;
  bool isChecked = false;

  TaskCard({
    Key key,
    this.task,
    this.index,
    this.removalFunc,
    this.completionFunc,
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  var alarm = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: deviceSize.width * .075,
          top: 15,
          right: deviceSize.width * .075,
          bottom: 5),
      width: deviceSize.width * .85,
      height: deviceSize.height * .1333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1.5),
          )
        ],
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => widget.removalFunc(context, widget.index),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15,),
              child: FaIcon(
                FontAwesomeIcons.times,
                size: 27,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 14, top: 14),
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: widget.task.category.color),
                child: Text(
                  widget.task.category.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: widget.task.category.txtColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 14, bottom: 24),
                child: Container(
                  width: deviceSize.width * .55,
                  height: 25,
                  child: Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Checkbox(
              checkColor: Theme.of(context).accentColor,
              activeColor: Theme.of(context).primaryColor,
              value: widget.isChecked,
              onChanged: (val) {
                setState(() {
                  widget.isChecked = !widget.isChecked;
                  Future.delayed(Duration(milliseconds: 300),
                      () => widget.completionFunc(context, widget.index));
                });
              }),
        ],
      ),
    );
  }
}
