import 'package:flutter/material.dart';

class AuthPassword extends StatelessWidget {
  const AuthPassword({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final void Function(String? email) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.trim().length < 6) {
          return 'Password must be at least 6 characters long.';
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
