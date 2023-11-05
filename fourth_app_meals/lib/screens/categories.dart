import 'package:flutter/material.dart';
import 'package:fourth_app_meals/data/dummy_data.dart';
import 'package:fourth_app_meals/wirgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick you category'),
      ),
      body: GridView(
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
            ),
        ],
      ),
    );
  }
}
