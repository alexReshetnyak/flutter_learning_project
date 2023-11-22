import 'package:flutter/material.dart';
import 'package:fourth_app_meals/data/dummy_data.dart';
import 'package:fourth_app_meals/models/category.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/screens/meals.dart';
import 'package:fourth_app_meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// with - is a way of adding additional functionality to a class (mixins).
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late - means that the variable will be initialized later
  late AnimationController _animationController;

// initState - is called when the object is inserted into the tree. (if the route was already in the tree, this method is not called again)
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 500),
      lowerBound: 0, // the lower bound of the animation's value
      upperBound: 1, // 0 and 1 are the default values
    );

// forward - starts running this animation in the forward direction, from 0.0 to 1.0.
    _animationController.forward();
  }

// dispose - is called when the object is removed, at the end of the lifecycle of a StatefulWidget.
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(
      //     top: 100 - _animationController.value * 100,
      //   ),
      //   child: child,
      // ),
      builder: (context, child) => SlideTransition(
        // Tween - is a linear interpolation between a beginning and ending value.
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
