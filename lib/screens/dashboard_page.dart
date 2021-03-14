import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/weekly_report_card.dart';
import '../widgets/animated_task_list.dart';
import '../providers/tasks.dart';

class DashboardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var taskProvider = Provider.of<Tasks>(context);
    var date = DateTime.now();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: deviceSize.width * .075,
                ),
                child: Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: deviceSize.width * .075,
                ),
                child: Text(
                  'Good to see you again!',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          WeeklyReportCard(deviceSize: deviceSize),
          Padding(
            padding: EdgeInsets.only(left: deviceSize.width * .075, top: 20),
            child: Text(
              'Your tasks for the day',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 25),
            ),
          ),
          AnimatedTaskList(
            taskProvider.tasks
                .where((task) =>
                    task.date.year == date.year &&
                    task.date.month == date.month &&
                    task.date.day == date.day &&
                    !task.isDone)
                .toList(),
          ),
        ],
      ),
    );
  }
}
