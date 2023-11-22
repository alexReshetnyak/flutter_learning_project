import 'package:flutter/material.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/widgets/meal_item/meal_item_positioned.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    required this.meal,
    required this.onSelectMeal,
    super.key,
  });

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    // Card - A material design card. A card has slightly rounded corners and a shadow.
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge, // Clip the card's content to its shape.
      elevation: 2, // elevation of the card relative to its parent
      child: InkWell(
        // InkWell - A rectangular area of a Material that responds to touch.
        onTap: () => onSelectMeal(meal),
        child: Stack(
          // Stack - A widget that positions its children relative to the edges of its box.
          children: [
            // Hero - A widget that marks its child as being a candidate for hero animations.
            Hero(
              tag: meal.id,
              // FadeInImage - A widget that shows a placeholder image while the target image is loading.
              child: FadeInImage(
                // MemoryImage - Fetches an image from an Uint8List.
                placeholder: MemoryImage(
                  kTransparentImage,
                ),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            MealItemPositioned(meal: meal)
          ],
        ),
      ),
    );
  }
}
