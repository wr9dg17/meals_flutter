import 'package:flutter/material.dart';

import 'package:meals_flutter/data/meals.dart';
import 'package:meals_flutter/models/meal.dart';
import 'package:meals_flutter/screens/tabs_screen.dart';
import 'package:meals_flutter/screens/filters_screen.dart';
import 'package:meals_flutter/screens/meals_screen.dart';
import 'package:meals_flutter/screens/meal_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = kMeals;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = kMeals.where((meal) {
        if (filterData['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (filterData['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (filterData['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (filterData['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final mealIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (mealIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(mealIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(kMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ).copyWith(secondary: Colors.amber),
        canvasColor: Colors.grey.shade100,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodySmall: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleMedium: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: TabsScreen.id,
      routes: {
        TabsScreen.id: (context) => TabsScreen(favouriteMeals: _favouriteMeals),
        FiltersScreen.id: (context) {
          return FiltersScreen(
            filters: _filters,
            saveFilters: _setFilters,
          );
        },
        MealsScreen.id: (context) => MealsScreen(meals: _availableMeals),
        MealDetailsScreen.id: (context) {
          return MealDetailsScreen(
            isFavourite: _isFavourite,
            toggleFavourite: _toggleFavourite,
          );
        },
      },
    );
  }
}
