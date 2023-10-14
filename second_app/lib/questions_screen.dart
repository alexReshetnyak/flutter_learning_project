import 'package:flutter/material.dart';
import 'package:second_app/answer_button.dart';

// ignore: must_be_immutable
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

// private class (only in this file)
class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // vertical alignment
        children: [
          const Text(
            'The question...',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 30),
          AnswerButton(answerText: 'Answer text 1', onTap: () {}),
          AnswerButton(onTap: () {}, answerText: 'Answer text 2'),
        ],
      ),
    );
  }
}
