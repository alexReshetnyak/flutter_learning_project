import 'package:flutter/material.dart';

import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        // body: GradientContainer(
        //   Color.fromARGB(255, 255, 255, 118),
        //   Colors.deepOrange,
        // ),
        body: GradientContainer.purple(),
        // backgroundColor: Color.fromARGB(255, 226, 201, 201),
      ),
    ),
  );
}



// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Welcome to Flutter')),
//         body: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(12),
//           child: const Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Flutter - the guide 1 12 123 1234 12345',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               SizedBox(
//                 height: 16,
//               ),
//               Text('Learn Flutter')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
