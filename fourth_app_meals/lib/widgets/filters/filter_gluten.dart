import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fourth_app_meals/providers/filters_provider.dart';

class FilterGluten extends ConsumerWidget {
  const FilterGluten({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    // SwitchListTile - is a widget that provides a nice way to create a list item with a switch
    return SwitchListTile(
      value: activeFilters[FilterOptions.glutenFree]!,
      onChanged: (isChecked) {
        ref
            .read(filtersProvider.notifier)
            .setFilter(FilterOptions.glutenFree, isChecked);
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
