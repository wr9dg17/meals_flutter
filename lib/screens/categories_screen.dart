import 'package:flutter/material.dart';

import 'package:meals_flutter/data/categories.dart';
import 'package:meals_flutter/widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  static const String id = 'caretogies-screen';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      childAspectRatio: 3 / 2,
      children: kCategories
          .map((c) => CategoryCard(
                id: c.id,
                title: c.title,
                color: c.color,
              ))
          .toList(),
    );
  }
}
