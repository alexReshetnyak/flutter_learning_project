import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  // AnswerButton(this.answerText, this.onTap, {Key? key}) : super(key: key);
  // const AnswerButton(this.answerText, this.onTap, {super.key});
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 55, 0),
        foregroundColor: Colors.white,
      ),
      child: Text(answerText),
    );
  }
}
