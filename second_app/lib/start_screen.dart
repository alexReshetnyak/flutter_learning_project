import 'package:flutter/material.dart';
// import 'package:first_app/styled_text.dart';

// ignore: must_be_immutable
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/image_1.png',
            width: 300,
          ),
          const SizedBox(height: 20),
          const Text('Learn Flutter!'),
        ],
      ),
    );
  }
}
