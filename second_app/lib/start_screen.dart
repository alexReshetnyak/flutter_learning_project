import 'package:flutter/material.dart';
// import 'package:first_app/styled_text.dart';

// ignore: must_be_immutable
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/image_1.png',
            width: 300,
            color: Color.fromARGB(117, 255, 255, 255), // 117 transparent
          ),
          // Opacity( // Works but not performance expensive
          //   opacity: 0.7,
          //   child: Image.asset(
          //     'assets/images/image_1.png',
          //     width: 300,
          //   ),
          // ),
          const SizedBox(height: 20),
          const Text(
            'Learn Flutter!',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 211, 211), fontSize: 30),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
              onPressed: () {
                startQuiz();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Start Quiz')),
        ],
      ),
    );
  }
}
