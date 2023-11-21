import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterOptions {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  // The initial value for the state.
  FiltersNotifier()
      : super({
          FilterOptions.glutenFree: false,
          FilterOptions.lactoseFree: false,
          FilterOptions.vegetarian: false,
          FilterOptions.vegan: false,
        });

  void setFilter(FilterOptions filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<FilterOptions, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>(
  (ref) => FiltersNotifier(),
);
