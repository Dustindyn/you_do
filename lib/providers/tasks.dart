import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';
import '../models/category.dart';

class Tasks with ChangeNotifier {
  GlobalKey<AnimatedListState> listKey;

  Tasks() {
    SharedPreferences.getInstance().then(
      (prefs) {
        var taskStringList = prefs.getStringList('tasks');
        if (taskStringList != null) {
          for (String task in taskStringList) {
            print(task);
            var taskJson = jsonDecode(task);
            addTask(Task.fromJson(taskJson));
          }
        }
        var categoryStringList = prefs.getStringList('categories');
        if (categoryStringList != null) {
          for (String category in categoryStringList) {
            var categoryJson = jsonDecode(category);
            addCategory(Category.fromJson(categoryJson));
          }
        }
      },
    );
  }

  Future<void> saveTaskDataOnDevice() {
    return SharedPreferences.getInstance().then(
      (prefs) {
        List<String> dataToSave = [];
        _tasks.forEach(
          (task) => dataToSave.add(
            jsonEncode(task.toJson()),
          ),
        );
        prefs.setStringList('tasks', dataToSave);
      },
    );
  }

  Future<void> saveCategoryDataOnDevice() {
    return SharedPreferences.getInstance().then(
      (prefs) {
        List<String> dataToSave = [];
        _categories.forEach(
          (category) => dataToSave.add(
            jsonEncode(category.toJson()),
          ),
        );
        prefs.setStringList('categories', dataToSave);
      },
    );
  }

  final List<Category> _categories = [
  ];

  List<Task> _tasks = [
  ];

  List<Category> get categories {
    return [..._categories];
  }

  List<Task> get tasks {
    return [..._tasks];
  }

  void removeTask(Task task) {
    _tasks.removeWhere((tsk) =>
        tsk.description == task.description && tsk.date.day == task.date.day);
    notifyListeners();
    saveTaskDataOnDevice();
  }

  void completeTask(Task task) {
    _tasks
        .firstWhere((tsk) =>
            tsk.description == task.description &&
            tsk.date.day == task.date.day)
        .isDone = true;
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    //Saving the key of the last built animated list ensures that its state gets updated properly on insertion of a new task, since it may not get rebuild automatically
    listKey.currentState.insertItem(
      tasks.length - 1,
      duration: const Duration(milliseconds: 500),
    );
    notifyListeners();
    saveTaskDataOnDevice();
  }

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
    saveCategoryDataOnDevice();
  }
}
