import 'package:flutter/material.dart';

import '../widgets/category_card_list.dart';
import './new_category_popup_screen.dart';

_showCategoryDialog(BuildContext context) {
  showDialog(context: context, builder: (_) => NewCategoryPopupScreen());
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: deviceSize.width * .075,
            right: deviceSize.width * .075,
            bottom: 15,
          ),
          child: Text(
            'Life has many facets and so do you!',
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.left,
          ),
        ),
        CategoryCardList(),
        Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 60,
                  color: Theme.of(context).buttonColor,
                ),
                onPressed: () => _showCategoryDialog(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
