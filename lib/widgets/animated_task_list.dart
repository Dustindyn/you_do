import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../models/task.dart';
import './task_card.dart';


class AnimatedTaskList extends StatefulWidget {
  final List<Task> tasks;
  AnimatedTaskList(this.tasks);

  @override
  _AnimatedTaskListState createState () => _AnimatedTaskListState();
}

class _AnimatedTaskListState extends State<AnimatedTaskList> {
  GlobalKey<AnimatedListState> key;
  @override
  void initState() {
    super.initState();
    key = GlobalKey<AnimatedListState>();
    
  }

  Widget _buildItem(BuildContext context, Task item, int index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: TaskCard(
        key: UniqueKey(),
        task: item,
        index: index,
        completionFunc: completeTask,
        removalFunc: removeTask,
      ),
    );
  }

  
  void completeTask(BuildContext context, int index) {
    final item = widget.tasks.removeAt(index);
    Provider.of<Tasks>(context, listen: false).completeTask(item);
    key.currentState.removeItem(
      index,
      (context, animation) => _buildItem(context, item, index, animation),
      duration: const Duration(milliseconds: 300),
    );
  }

  void removeTask(BuildContext context, int index) {
    final item = widget.tasks.removeAt(index);
    Provider.of<Tasks>(context, listen: false).removeTask(item);
    key.currentState.removeItem(
      index,
      (context, animation) => _buildItem(context, item, index, animation),
      duration: const Duration(milliseconds: 300),
    );
  }

  void insertTask(int index, Task item) {
    key.currentState.insertItem(
      index,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Saving the key of the last built animated list ensures that its state gets updated properly on insertion of a new task, since it may not get rebuild automatically
    Provider.of<Tasks>(context, listen:false).listKey = key;
    return Container(
      height: (widget.tasks.length + 2) * MediaQuery.of(context).size.height * .1333,
      child: AnimatedList(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          key: key,
          initialItemCount: widget.tasks.length,
          itemBuilder: (context, index, animation) {
            if(index>widget.tasks.length-1)
            {
              return Container();
            }
            return _buildItem(context, widget.tasks[index], index, animation);
          }),
    );
  }
}
