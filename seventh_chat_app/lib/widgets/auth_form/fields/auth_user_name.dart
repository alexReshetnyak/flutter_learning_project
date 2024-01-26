import 'package:flutter/material.dart';

class AuthUsername extends StatelessWidget {
  const AuthUsername({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final void Function(String? email) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Username'),
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty || value.trim().length < 4) {
          return 'Please enter at least 4 characters.';
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
