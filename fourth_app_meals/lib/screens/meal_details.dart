import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/providers/favorites_provider.dart';
import 'package:fourth_app_meals/widgets/meal_details/meal_details_ingredients.dart';
import 'package:fourth_app_meals/widgets/meal_details/meal_details_steps.dart';

// ConsumerWidget - is a widget that allows you to listen to a provider and
// rebuild your UI when the value changes.
class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  void _onFavoriteBtnPressed(WidgetRef ref, BuildContext context) {
    // ref.read - read a provider without listening to it
    final wasAdded =
        ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasAdded ? 'Added to favorites' : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final bool isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () => _onFavoriteBtnPressed(ref, context),
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
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
