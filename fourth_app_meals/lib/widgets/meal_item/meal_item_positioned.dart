import 'package:flutter/material.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/widgets/meal_item/meal_item_trait.dart';

class MealItemPositioned extends StatelessWidget {
  const MealItemPositioned({
    required this.meal,
    super.key,
  });

  final Meal meal;

  Widget get title {
    return Text(
      meal.title,
      maxLines: 2,
      textAlign: TextAlign.center,
      softWrap: true, // wrap text if it's too long
      overflow: TextOverflow.ellipsis, // show ... if it's too long
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  String get complexityText {
    // Capitalize the first letter of the complexity name.
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    // Capitalize the first letter of the complexity name.
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // Positioned - A widget that controls where a child of a Stack is positioned.
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 44,
        ),
        child: Column(
          children: [
            title,
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MealItemTrait(
                  icon: Icons.schedule,
                  label: '${meal.duration} min',
                ),
                SizedBox(width: 12),
                MealItemTrait(
                  icon: Icons.work,
                  label: complexityText,
                ),
                SizedBox(width: 12),
                MealItemTrait(
                  icon: Icons.attach_money,
                  label: affordabilityText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
