import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../painters/custom_container_overlay_painter.dart';
import '../providers/tasks.dart';

class WeeklyReportCard extends StatelessWidget {
  final Size deviceSize;
  WeeklyReportCard({this.deviceSize});

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    final numberOfTasks = tasks.tasks.length;
    final numberOfCompletedTasks =
        (tasks.tasks.where((task) => task.isDone).length);
    final progress = numberOfCompletedTasks / numberOfTasks;
    return Padding(
      padding: EdgeInsets.only(left: deviceSize.width * .075, top: 30),
      child: Stack(
        children: [
          Container(
            height: deviceSize.height * .2,
            width: deviceSize.width * .85,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1.5),
                )
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 10),
                  child: CircularPercentIndicator(
                    animation: true,
                    radius: 90.0,
                    lineWidth: 5.0,
                    percent: progress,
                    center: progress == double.nan
                        ? Text(
                            '0%',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: 15,
                                    ),
                          )
                        : Text(
                            (progress * 100).toStringAsFixed(2) + "%",
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                    progressColor: Theme.of(context).primaryColor,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tasks\ncompleted',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 22)),
                    Text(
                        numberOfCompletedTasks.toString() +
                            "/" +
                            numberOfTasks.toString() +
                            " done",
                        style: Theme.of(context).textTheme.bodyText1)
                  ],
                )
              ],
            ),
          ),
          Positioned(
            child: Container(
              height: deviceSize.height * .2,
              width: deviceSize.width * .875,
              child: CustomPaint(
                painter: CustomContainerOverlayPainter(
                    Theme.of(context).primaryColor),
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 50,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                'Weekly\nreport',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
