import 'package:flutter/material.dart';
import 'package:trivia_quiz/home_screen/home_screen.dart';

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Quiz',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
