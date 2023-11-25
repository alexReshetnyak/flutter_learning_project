import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sixth_app_favorite_places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  // initial state is an empty list
  UserPlacesNotifier() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) {
  return UserPlacesNotifier();
});
