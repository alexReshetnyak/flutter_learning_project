import 'package:flutter/material.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/screens/meal_details.dart';
import 'package:fourth_app_meals/widgets/meal_item/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
  });

  // ? - means that the value can be null
  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    // pop - Remove the top widget of the navigator. (go back)
    // Navigator.of(context).pop();

    // push - Push the given route onto the navigator. (a new screen will be shown with back button)
    Navigator.of(context).push(
      // MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition.
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return MealItem(
          meal: meals[index],
          onSelectMeal: (meal) => selectMeal(context, meal),
          key: ValueKey(meals[index].id), // for performance optimization
        );
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    return title == null
        ? content
        : Scaffold(
            appBar: AppBar(
              title: Text(title!), // ! - means that the value is not null
            ),
            body: content,
          );
  }
}
