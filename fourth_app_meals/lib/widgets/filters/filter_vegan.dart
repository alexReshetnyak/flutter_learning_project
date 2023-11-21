import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fourth_app_meals/providers/filters_provider.dart';

class FilterVegan extends ConsumerWidget {
  const FilterVegan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    // SwitchListTile - is a widget that provides a nice way to create a list item with a switch
    return SwitchListTile(
      value: activeFilters[FilterOptions.vegan]!,
      onChanged: (isChecked) {
        ref
            .read(filtersProvider.notifier)
            .setFilter(FilterOptions.vegan, isChecked);
      },
      title: Text(
        'Vegan',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        'Only include vegan meals.',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 32, right: 22),
    );
  }
}
