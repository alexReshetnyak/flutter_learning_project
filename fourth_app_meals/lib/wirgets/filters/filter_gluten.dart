import 'package:flutter/material.dart';
import 'package:fourth_app_meals/screens/filters.dart';

class FilterGluten extends StatelessWidget {
  const FilterGluten({
    super.key,
    required this.onSelectFilter,
    required this.glutenFreeFilterSet,
  });

  final void Function(FilterOptions filterName, bool isChecked) onSelectFilter;
  final bool glutenFreeFilterSet;

  @override
  Widget build(BuildContext context) {
    // SwitchListTile - is a widget that provides a nice way to create a list item with a switch
    return SwitchListTile(
      value: glutenFreeFilterSet,
      onChanged: (isChecked) {
        onSelectFilter(FilterOptions.glutenFree, isChecked);
      },
      title: Text(
        'Gluten-free',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        'Only include gluten-free meals.',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 32, right: 22),
    );
  }
}
