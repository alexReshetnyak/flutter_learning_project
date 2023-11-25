import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sixth_app_favorite_places/screens/places.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 102, 6, 247),
  background: Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
    ));

void main() {
  // ProviderScope is a widget that contains providers (and makes them available to the rest of the widget tree)
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme,
      home: PlacesScreen(),
    );
  }
}
