import 'package:flutter/material.dart';
import 'package:fourth_app_meals/models/meal.dart';

class MealDetailsSteps extends StatelessWidget {
  const MealDetailsSteps({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Steps:',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        for (var step in meal.steps)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              step,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
      ],
    );
  }
}
