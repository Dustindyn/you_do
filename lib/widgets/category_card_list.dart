import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_card.dart';
import '../providers/tasks.dart';

class CategoryCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final categories = Provider.of<Tasks>(context).categories;
    return Container(
      height: deviceSize.height * .45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories
            .map(
              (category) => CategoryCard(category),
            )
            .toList(),
      ),
    );
  }
}
