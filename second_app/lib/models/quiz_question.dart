class QuizQuestion {
  QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    final List<String> shuffledAnswers = List.of(answers); // * copy the list
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}
