import 'package:flutter/material.dart';

class AuthControls extends StatelessWidget {
  const AuthControls({
    Key? key,
    required this.isAuthenticating,
    required this.isLogin,
    required this.submit,
    required this.toggleLogin,
  }) : super(key: key);

  final bool isAuthenticating;
  final bool isLogin;
  final void Function() submit;
  final void Function() toggleLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isAuthenticating) const CircularProgressIndicator(),
        if (!isAuthenticating)
          ElevatedButton(
            onPressed: submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              isLogin ? 'Login' : 'Sign up',
            ),
          ),
        if (!isAuthenticating)
          TextButton(
            onPressed: toggleLogin,
            child: Text(
              isLogin ? 'Create an account' : 'I already have an account',
            ),
          ),
      ],
    );
  }
}
