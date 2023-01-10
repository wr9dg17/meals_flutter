import 'package:flutter/material.dart';

import 'package:meals_flutter/models/meal.dart';
import 'package:meals_flutter/widgets/meal_card.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> meals;

  const FavouritesScreen({
    Key? key,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const Center(
        child: Text('You have no favourites yet - start adding one!'),
      );
    } else {
      return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealCard(
            id: meals[index].id,
            title: meals[index].title,
            imageUrl: meals[index].imageUrl,
            duration: meals[index].duration,
            complexity: meals[index].complexity,
            affordability: meals[index].affordability,
          );
        },
      );
    }
  }
}
