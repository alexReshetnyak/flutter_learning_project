import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:sixth_app_favorite_places/models/place.dart';

Database? _db;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  if (_db != null) return _db!;

  _db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    },
  );

  return _db!;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  // initial state is an empty list
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();

    final data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String title, File image) async {
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    // copy the image to the app directory
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(title: title, image: copiedImage);

    final db = await _getDatabase();

    await db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) {
  return UserPlacesNotifier();
});
