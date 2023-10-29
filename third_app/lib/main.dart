import 'package:flutter/material.dart';
import 'package:third_app/widgets/expenses.dart';

// k means global constant
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 60, 232),
);

var kDartColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark, // color scheme for dark mode
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDartColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kDartColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDartColorScheme.primaryContainer,
            foregroundColor: kDartColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      // theme: ThemeData(useMaterial3: true),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        // scaffoldBackgroundColor: Color.fromARGB(255, 252, 250, 223),
        colorScheme: kColorScheme,

        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),

        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),

        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16,
            )),
      ),
      // themeMode: ThemeMode.system,
      themeMode: ThemeMode.dark,
      home: const Expenses(),
    );
  }
}
