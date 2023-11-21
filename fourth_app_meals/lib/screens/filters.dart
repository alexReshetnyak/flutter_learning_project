import 'package:flutter/material.dart';
import 'package:fourth_app_meals/wirgets/filters/filter_gluten.dart';
import 'package:fourth_app_meals/wirgets/filters/filter_lactose.dart';
import 'package:fourth_app_meals/wirgets/filters/filter_vegan.dart';
import 'package:fourth_app_meals/wirgets/filters/filter_vegetarian.dart';

enum FilterOptions {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<FilterOptions, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

// initState - is a method that is executed before build() method
  @override
  void initState() {
    super.initState();

    _glutenFreeFilterSet = widget.currentFilters[FilterOptions.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[FilterOptions.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[FilterOptions.vegetarian]!;
    _veganFilterSet = widget.currentFilters[FilterOptions.vegan]!;
  }

  void onSelectFilter(FilterOptions filterName, bool isChecked) {
    setState(() {
      switch (filterName) {
        case FilterOptions.glutenFree:
          _glutenFreeFilterSet = isChecked;
          break;
        case FilterOptions.lactoseFree:
          _lactoseFreeFilterSet = isChecked;
          break;
        case FilterOptions.vegetarian:
          _vegetarianFilterSet = isChecked;
          break;
        case FilterOptions.vegan:
          _veganFilterSet = isChecked;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();

      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) {
      //           return const TabsScreen();
      //         }),
      //       );
      //     }
      //   },
      // ),
      // WillPopScope - is a widget that allows us to intercept the back button
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            FilterOptions.glutenFree: _glutenFreeFilterSet,
            FilterOptions.lactoseFree: _lactoseFreeFilterSet,
            FilterOptions.vegetarian: _vegetarianFilterSet,
            FilterOptions.vegan: _veganFilterSet,
          });

          // return false - means that we don't want to close the screen (we closed it manually with pop)
          return false;
        },
        child: Column(
          children: [
            FilterGluten(
              onSelectFilter: onSelectFilter,
              glutenFreeFilterSet: _glutenFreeFilterSet,
            ),
            FilterLactose(
              onSelectFilter: onSelectFilter,
              glutenFreeFilterSet: _lactoseFreeFilterSet,
            ),
            FilterVegetarian(
              onSelectFilter: onSelectFilter,
              glutenFreeFilterSet: _vegetarianFilterSet,
            ),
            FilterVegan(
              onSelectFilter: onSelectFilter,
              glutenFreeFilterSet: _veganFilterSet,
            )
          ],
        ),
      ),
    );
  }
}
