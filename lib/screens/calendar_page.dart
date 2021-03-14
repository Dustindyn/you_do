import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../widgets/calendar_day_card.dart';
import '../widgets/animated_task_list.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now().add(Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    final deviceSize = MediaQuery.of(context).size;
    final days = List.generate(
      6,
      (i) => DateTime.now().add(
        Duration(days: i+1),
      ),
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: deviceSize.width * .075,
                ),
                child: Text(
                  'Pick a day',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: deviceSize.width * .075,
                  top: deviceSize.height * .04,
                ),
                child: SizedBox(
                  height: deviceSize.height * .13,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (ctx, i) => InkWell(
                      onTap: () {
                        setState(() {
                          _selectedDay = days[i];
                        });
                      },
                      child: CalendarDayCard(days[i],
                          isClicked: days[i].day == _selectedDay.day, index: i),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: deviceSize.width * .075,
                  top: deviceSize.height * .04,
                ),
                child: Text(
                  'Upcoming Tasks',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
              AnimatedTaskList(
                tasks.tasks
                    .where(
                      (task) =>
                          task.date.year == _selectedDay.year &&
                          task.date.month == _selectedDay.month &&
                          task.date.day == _selectedDay.day &&
                          !task.isDone,
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
