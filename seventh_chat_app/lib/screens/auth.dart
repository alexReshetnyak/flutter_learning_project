import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seventh_chat_app/bloc/counter_bloc.dart';
import 'package:seventh_chat_app/bloc/counter_event.dart';
import 'package:seventh_chat_app/widgets/auth_form/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late CounterBloc counterBloc;
  late StreamSubscription<int> subscription;
  int counter = 0;

  @override
  void initState() {
    counterBloc = CounterBloc();

    print(counterBloc.state); // 0

    subscription = counterBloc.stream.listen((data) {
      setState(() {
        counter = data;
      });
    }); // 0

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await subscription.cancel();
    counterBloc.close();
  }

  void _incrementCounter() async {
    counterBloc.add(CounterIncrementPressed());
    // await Future.delayed(Duration.zero);
    // print(counterBloc.state); // 1
  }

  @override
  Widget build(BuildContext context) {
    final authScreen = Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              const Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: AuthForm(),
                ),
              ),
              Text(counter.toString()),
              StreamBuilder(
                stream: counterBloc.stream,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: const TextStyle(fontSize: 25),
                  );
                },
              ),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Color.fromARGB(255, 250, 250, 250),
                      width: 5,
                    ),
                  ),
                ),
                onPressed: _incrementCounter,
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    return authScreen;
  }
}
