import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../providers/tasks.dart';

class BalanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    final tasks = tasksProvider.tasks;
    final data = tasksProvider.categories
        .map(
          (role) => TasksPerRole(
              role.title,
              tasks.where((task) => task.category.title == role.title).length,
              role.color),
        )
        .toList();
    final series = [
      charts.Series(
        id: 'tasks',
        domainFn: (TasksPerRole taskData, _) => taskData.roleName,
        measureFn: (TasksPerRole taskData, _) => taskData.numberTasks,
        colorFn: (TasksPerRole taskData, _) => taskData.color,
        data: data,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.Color(
              r: Theme.of(context).buttonColor.red,
              g: Theme.of(context).buttonColor.green,
              b: Theme.of(context).buttonColor.blue,
              a: Theme.of(context).buttonColor.alpha,
            ),
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.Color(
              r: Theme.of(context).primaryColor.red,
              g: Theme.of(context).primaryColor.green,
              b: Theme.of(context).primaryColor.blue,
              a: Theme.of(context).primaryColor.alpha,
            ),
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.Color(
              r: Theme.of(context).buttonColor.red,
              g: Theme.of(context).buttonColor.green,
              b: Theme.of(context).buttonColor.blue,
              a: Theme.of(context).buttonColor.alpha,
            ),
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.Color(
              r: Theme.of(context).primaryColor.red,
              g: Theme.of(context).primaryColor.green,
              b: Theme.of(context).primaryColor.blue,
              a: Theme.of(context).primaryColor.alpha,
            ),
          ),
        ),
      ),
    );
  }
}

class TasksPerRole {
  final String roleName;
  final int numberTasks;
  final charts.Color color;

  TasksPerRole(this.roleName, this.numberTasks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
