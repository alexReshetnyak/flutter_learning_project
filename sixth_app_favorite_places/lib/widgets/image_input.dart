import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) return;

    _selectedImage = File(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: content,
    );
  }
}
