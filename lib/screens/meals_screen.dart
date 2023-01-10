import 'package:flutter/material.dart';

import 'package:meals_flutter/models/meal.dart';
import 'package:meals_flutter/widgets/meal_card.dart';

class MealsScreen extends StatelessWidget {
  static const String id = 'meals-screen';
  final List<Meal> meals;

  const MealsScreen({Key? key, required this.meals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryMeals = meals.where((meal) => meal.categories.contains(args['id'])).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title'] as String),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) {
          return MealCard(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
          );
        },
      ),
    );
  }
}
