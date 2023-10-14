import 'package:second_app/models/quiz_question.dart';

var questions = [
  QuizQuestion(
    'What are the main building blocks of Flutter UIs?',
    [
      'Widgets',
      'Components',
      'Blocks',
      'Functions',
    ],
  ),
  QuizQuestion('How are the Flutter UIs built?', [
    'By combining widgets in code',
    'By using drag and drop',
    'By using a visual editor',
    'By using using XCode for iOS and Android Studio for Android',
  ]),
  QuizQuestion('What\'s the purpose of StatefulWidgets?', [
    'Update UI as data changes',
    'Update data as UI changes',
    'Ignore changes in data',
    'Render UI that does not relay on data',
  ]),
  QuizQuestion('Which widget should you try to use more often?', [
    'StatelessWidget',
    'StatefulWidget',
    'Both are equally good',
    'None of the above',
  ]),
  QuizQuestion('What happens when you change data in Stateless Widgets?', [
    'UI is not updated',
    'UI is updated',
    'The closet StatefulWidget is updated',
    'Any nested StatefulWidgets are updated',
  ]),
  QuizQuestion('How should you update data inside of Stateful Widgets?', [
    'By calling setState()',
    'By calling updateState()',
    'By calling updateData()',
    'By calling updateUI()',
  ]),
];
