import 'package:flutter/material.dart';
import 'package:trivia_quiz/quiz_screen/quiz_screen.dart';

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Trivia Quiz"),
        ),
        body: const QuizScreen(difficulty: "easy"),
      ),
    );
  }
}
