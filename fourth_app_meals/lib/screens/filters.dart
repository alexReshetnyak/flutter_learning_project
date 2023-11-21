import 'package:flutter/material.dart';
import 'package:fourth_app_meals/widgets/filters/filter_gluten.dart';
import 'package:fourth_app_meals/widgets/filters/filter_lactose.dart';
import 'package:fourth_app_meals/widgets/filters/filter_vegan.dart';
import 'package:fourth_app_meals/widgets/filters/filter_vegetarian.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // WillPopScope - is a widget that allows us to intercept the back button
      body: const Column(
        children: [
          FilterGluten(),
          FilterLactose(),
          FilterVegetarian(),
          FilterVegan()
        ],
      ),
    );
  }
}
