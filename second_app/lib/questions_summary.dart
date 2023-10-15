import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return Row(children: [
                Text(((data['question_index'] as int) + 1).toString()),
                // * to take all the available space
                Expanded(
                  child: Column(
                    children: [
                      Text(data['question'].toString()),
                      const SizedBox(height: 10),
                      Text(data['user_answer'] as String),
                      const SizedBox(height: 10),
                      Text(data['correct_answer'] as String),
                    ],
                  ),
                )
              ]);
            },
          ).toList(),
        ),
      ),
    );
  }
}
