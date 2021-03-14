import 'package:flutter/material.dart';

class Category {
  String title;
  Color color;
  Color txtColor;

  Map<String, dynamic> toJson() =>
      {'title': title, 'color': color.value, 'txtColor': txtColor.value};

  Category.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        color = Color(json['color']),
        txtColor = Color(json['txtColor']);

  Category({this.title, this.color, this.txtColor});
}
