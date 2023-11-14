import 'package:flutter/material.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/wirgets/meal_details/meal_details_ingredients.dart';
import 'package:fourth_app_meals/wirgets/meal_details/meal_details_steps.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final void Function(Meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () => onToggleFavorite(meal),
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      // SingleChildScrollView is used to make the content scrollable
      // ListView is another option
      // ListView.builder is used when the list is long and we don't want to load all the items at once
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover, // scale the image to fit the box
            ),
            const SizedBox(height: 14),
            MealDetailsIngredients(meal: meal),
            MealDetailsSteps(meal: meal)
          ],
        ),
      ),
    );
  }
}
