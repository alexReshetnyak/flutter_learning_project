import 'package:flutter/material.dart';
import 'package:second_app/start_screen.dart';

const Alignment startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;
const color1 = Color.fromARGB(255, 255, 26, 26);
const color2 = Colors.indigoAccent;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: startAlignment,
              end: endAlignment,
            ),
          ),
          child: const StartScreen(),
        ),
      ),
    ),
  );
}
