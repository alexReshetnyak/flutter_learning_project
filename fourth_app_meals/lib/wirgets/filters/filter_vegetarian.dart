import 'package:flutter/material.dart';
import 'package:fourth_app_meals/screens/filters.dart';

class FilterVegetarian extends StatelessWidget {
  const FilterVegetarian({
    super.key,
    required this.onSelectFilter,
    required this.glutenFreeFilterSet,
  });

  final void Function(FilterOptions filterNam, bool isChecked) onSelectFilter;
  final bool glutenFreeFilterSet;

  @override
  Widget build(BuildContext context) {
    // SwitchListTile - is a widget that provides a nice way to create a list item with a switch
    return SwitchListTile(
      value: glutenFreeFilterSet,
      onChanged: (isChecked) {
        onSelectFilter(FilterOptions.vegetarian, isChecked);
      },
      title: Text(
        'Vegetarian',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        'Only include vegetarian meals.',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 32, right: 22),
    );
  }
}
