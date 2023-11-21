import 'package:flutter/material.dart';
import 'package:fourth_app_meals/data/dummy_data.dart';
import 'package:fourth_app_meals/models/category.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/screens/meals.dart';
import 'package:fourth_app_meals/wirgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  final void Function(Meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator push method is used to push a new route onto the stack of routes managed by the navigator.
    // Navigator.of(context).push(route); // the same thing as below
    Navigator.push(
      context,
      // MaterialPageRoute is a modal route that replaces the entire screen with a platform-adaptive transition.
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      // SilverGridDelegateWithFixedCrossAxisCount is a delegate that controls the layout of the children within a GridView.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of columns
        childAspectRatio: 3 / 2, // width / height
        crossAxisSpacing: 20, // horizontal space between columns
        mainAxisSpacing: 20, // vertical space between rows
      ),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category, key: ValueKey(category.id),)).toList(),
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            key: ValueKey(category.id),
            onSelectCategory: () => _selectCategory(context, category),
          ),
      ],
    );
  }
}
