import 'package:flutter/material.dart';
import 'package:meals_flutter/data/meals.dart';

class MealDetailsScreen extends StatelessWidget {
  static const id = 'meal-details-screen';
  final Function isFavourite;
  final Function toggleFavourite;

  const MealDetailsScreen({
    Key? key,
    required this.isFavourite,
    required this.toggleFavourite,
  }) : super(key: key);

  Widget renderSectionTitle(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = kMeals.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  renderSectionTitle(context, 'Ingredients'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (ctx, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  renderSectionTitle(context, 'Steps'),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (ctx, index) => ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text('#${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    separatorBuilder: (ctx, index) => const Divider(),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavourite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavourite(mealId),
      ),
    );
  }
}
