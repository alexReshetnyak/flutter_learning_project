import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();
const Alignment startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

// ignore: must_be_immutable
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// private class (only in this file)
class _DiceRollerState extends State<DiceRoller> {
  int currentImageNumber = 1;

  void rollDice() {
    if (kDebugMode) {
      print('Button was pressed!!!!!!!');
    }

    setState(() {
      currentImageNumber = randomizer.nextInt(3) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/image_$currentImageNumber.png',
          height: 300,
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
              // padding: const EdgeInsets.only(
              //   top: 20,
              // ),
              ),
          child: const Text('Press me!'),
        ),
        // TextButton(
        //   onPressed: rollDice,
        //   style: TextButton.styleFrom(
        //     foregroundColor: Colors.white,
        //     padding: const EdgeInsets.only(
        //       top: 10,
        //     ),
        //     textStyle: const TextStyle(
        //       fontSize: 28,
        //     ),
        //   ),
        //   child: const Text('Press me 2!'),
        // )
      ],
    );
  }
}
