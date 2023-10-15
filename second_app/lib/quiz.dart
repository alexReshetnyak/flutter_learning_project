import 'package:flutter/material.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/questions_screen.dart';
import 'package:second_app/results_screen.dart';
import 'package:second_app/start_screen.dart';

const Alignment startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;
const color1 = Color.fromARGB(255, 255, 26, 26);
const color2 = Colors.indigoAccent;

// ignore: must_be_immutable
class Quiz extends StatefulWidget {
  const Quiz({super.key}); // constructor

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// private class (only in this file)
class _QuizState extends State<Quiz> {
  // first approach to switch screens
  // Widget? activeScreen; // ?  - means that it can be null
  // @override
  // void initState() {
  //   super.initState();
  //   activeScreen = StartScreen(switchScreen);
  // }
  // void switchScreen() {
  //   setState(() {
  //     activeScreen = const QuestionsScreen();
  //   });
  // }

  final List<String> _selectedAnswers = []; // * private property
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      activeScreen = 'questions-screen';
      _selectedAnswers.clear(); //  _selectedAnswers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidget = 'start-screen' == activeScreen
    //     ? StartScreen(switchScreen)
    //     : const QuestionsScreen();

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2, Color.fromARGB(0, 29, 123, 255)],
              begin: startAlignment,
              end: endAlignment,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
