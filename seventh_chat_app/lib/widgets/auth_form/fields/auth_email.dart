import 'package:flutter/material.dart';

class AuthEmail extends StatelessWidget {
  const AuthEmail({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final void Function(String? email) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email address'),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value == null || value.trim().isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address.';
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}
