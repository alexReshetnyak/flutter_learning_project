import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/providers/filters_provider.dart';
import 'package:fourth_app_meals/providers/meals_provider.dart';

// StateNotifier - is a class that allows you to mutate a state and notify listeners.
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // : - initializer list
  // [] - initial value
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }

    // .. - cascade notation
    // state = [...state]..add(meal);
    state = [...state, meal];
    return true;
  }
}

// StateNotifierProvider - is a provider that allows you to listen to a
// StateNotifier and rebuild your UI when the value changes.
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);

// Provider is different from StateNotifierProvider in that it doesn't allow you
// to mutate the state. It's useful for providing data that doesn't change.
final filteredMealsProvider = Provider((ref) {
  // this provider will be rebuilt when mealsProvider or filtersProvider changes
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList(); // toList() - returns a new list and not iterable
});
