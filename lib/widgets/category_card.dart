import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/tasks.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard(this.category);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final tasks = Provider.of<Tasks>(context);
    return Container(
        margin: EdgeInsets.only(left: deviceSize.width * .075, top: 8, bottom: 8),
        height: deviceSize.height * .4,
        width: deviceSize.width * .65,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1.5),
            )
          ],
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Spacer(),
                Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: deviceSize.height * .1,
                    width: deviceSize.width * .1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: category.color,
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 40),
              child: Text(
                category.title,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
            ),
            Spacer(),
             Padding(
              padding: EdgeInsets.only(left: 5, bottom: 40),
              child: Text(
                "Tasks: "+ tasks.tasks.where((task) => task.category.title == category.title).length.toString(),
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
            ),
            
          ],
        ));
  }
}
