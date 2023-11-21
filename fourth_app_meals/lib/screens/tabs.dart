import 'package:flutter/material.dart';
import 'package:fourth_app_meals/data/dummy_data.dart';
import 'package:fourth_app_meals/models/meal.dart';
import 'package:fourth_app_meals/screens/categories.dart';
import 'package:fourth_app_meals/screens/filters.dart';
import 'package:fourth_app_meals/screens/meals.dart';
import 'package:fourth_app_meals/wirgets/main_drawer/main_drawer.dart';

// k - is a prefix for global constants
const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<FilterOptions, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('${meal.title} removed from favorites');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('${meal.title} added to favorites');
      });
    }
  }

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
      final result = await Navigator.of(context).push<Map<FilterOptions, bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return FiltersScreen(currentFilters: _selectedFilters);
          },
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList(); // toList() - returns a new list and not iterable

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: [...availableMeals],
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
