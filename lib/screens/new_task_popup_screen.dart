import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../providers/tasks.dart';

class NewTaskPopupScreen extends StatefulWidget {
  @override
  _NewTaskPopupScreenState createState() => _NewTaskPopupScreenState();
}

class _NewTaskPopupScreenState extends State<NewTaskPopupScreen> {
  TextEditingController dateCtl = TextEditingController();
  var date = DateTime.now();
  final _form = GlobalKey<FormState>();
  String _currentSelectedRole;
  var _editedTask = Task(
    description: '',
    date: null,
    category: null,
    isDone: false,
  );

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Tasks>(context, listen: false).addTask(_editedTask);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    dateCtl.text = DateFormat.yMMMMd().format(date);
  }

  @override
  void dispose() {
    dateCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context, listen: false);
    final categoryNames = tasks.categories.map((category) => category.title).toList();
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        height: deviceSize.height * .6,
        width: deviceSize.width * .8,
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
            ]),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Add a new task!',
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: 22,
                  ),
            ),
          ),
          body: Form(
            key: _form,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 16.0,
                    bottom: 16,
                  ),
                  child: TextFormField(
                    maxLength: 30,
                    initialValue: "",
                    decoration: InputDecoration(
                      labelText: 'Describe your Task',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                      hintText: 'What are you planning to do?',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'You need to enter a task.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedTask = Task(
                        description: value,
                        date: _editedTask.date,
                        category: _editedTask.category,
                        isDone: _editedTask.isDone,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 16.0,
                    bottom: 16,
                  ),
                  child: TextFormField(
                    controller: dateCtl,
                      readOnly: true,
                      onTap: () async {
                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              Duration(days: 365),
                            ),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                        primary: Theme.of(context).buttonColor),
                                  ),
                                  colorScheme: ColorScheme.light().copyWith(
                                    surface: Theme.of(context).accentColor,
                                    onPrimary: Theme.of(context).buttonColor,
                                    onSurface: Theme.of(context).buttonColor,
                                    primary: Theme.of(context).primaryColor,
                                    secondary: Theme.of(context).accentColor,
                                    background: Theme.of(context).accentColor,
                                  ),
                                ),
                                child: child,
                              );
                            });
                        dateCtl.text = DateFormat.yMMMMd().format(date);
                      },
                      decoration: InputDecoration(
                        labelText: 'Pick a day.',
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onFieldSubmitted: (_) {
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please pick a date.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedTask = Task(
                        description: _editedTask.description,
                        date: date,
                        category: _editedTask.category,
                        isDone: _editedTask.isDone,
                      );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 16.0,
                    bottom: 16,
                  ),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    value: _currentSelectedRole,
                    hint: Text('Pick a category'),
                    isExpanded: true,
                    items: categoryNames.map((value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _currentSelectedRole = newValue;
                      });
                    },
                    isDense: true,
                    onSaved: (value) {
                      _editedTask = Task(
                        description: _editedTask.description,
                        date: _editedTask.date,
                        category: tasks.categories
                            .firstWhere((category) => category.title == value),
                        isDone: _editedTask.isDone,
                      );
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please pick a category';
                      }
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: _saveForm,
                  child: Container(
                    margin: const EdgeInsets.only(left: 70, right: 70, top: 50, bottom: 30),
                    padding: const EdgeInsets.all(12),
                    width: deviceSize.width * .4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(
                        35,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Done!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
