import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sixth_app_favorite_places/providers/user_places.dart';
import 'package:sixth_app_favorite_places/widgets/image_input.dart';
import 'package:sixth_app_favorite_places/widgets/location_input.dart';

class AddPlaceScreeen extends ConsumerStatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreeenState createState() => _AddPlaceScreeenState();
}

class _AddPlaceScreeenState extends ConsumerState<AddPlaceScreeen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) return;

    print('TES_TEST Place selected!');

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickedImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 10),
            const LocationInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              onPressed: _savePlace,
            ),
          ],
        ),
      ),
    );
  }
}
