import './category.dart';

class Task {
  final String description;
  final Category category;
  final DateTime date;
  bool isDone;

  Task({
    this.description,
    this.category,
    this.date,
    this.isDone,
  });

  Task.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        category = Category.fromJson(json['category']),
        date = DateTime.fromMillisecondsSinceEpoch(json['date']),
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'category': category.toJson(),
        'date': date.millisecondsSinceEpoch,
        'isDone': isDone
      };
}
