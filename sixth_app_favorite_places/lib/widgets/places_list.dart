import 'package:flutter/material.dart';
import 'package:sixth_app_favorite_places/models/place.dart';
import 'package:sixth_app_favorite_places/screens/place_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text('No places yet, start adding some!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];

        return ListTile(
          title: Text(
            place.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlaceDetailScreen(place: place),
              ),
            );
          },
        );
      },
    );
  }
}
