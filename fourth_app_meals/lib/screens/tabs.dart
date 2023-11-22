import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fourth_app_meals/providers/favorites_provider.dart';
import 'package:fourth_app_meals/providers/filters_provider.dart';
import 'package:fourth_app_meals/screens/categories.dart';
import 'package:fourth_app_meals/screens/filters.dart';
import 'package:fourth_app_meals/screens/meals.dart';
import 'package:fourth_app_meals/widgets/main_drawer/main_drawer.dart';

// k - is a prefix for global constants
const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
};

// ConsumerWidget - is a widget that allows you to listen to a provider and
// rebuild your UI when the value changes.
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// ConsumerState - is a state that allows you to listen to a provider and
// rebuild your UI when the value changes.
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    // close drawer
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      // Navigator.of(context).pushReplacement() - push new route and remove all previous routes
      // Navigator.of(context).push() - push new route and keep all previous routes
      // result - is a value that is returned from the pushed route
      await Navigator.of(context).push<Map<FilterOptions, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref is global here as we used ConsumerStatefulWidget
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: [...availableMeals],
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // ref.watch() - is a method that allows you to listen to a provider state
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      // bottomNavigationBar - A bottom navigation bar provides quick navigation between top-level views of an app.
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
