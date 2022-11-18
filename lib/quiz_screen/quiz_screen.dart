import 'package:flutter/material.dart';
import 'package:trivia_quiz/quiz_screen/question.dart';
import 'package:trivia_quiz/quiz_screen/result_screen.dart';
import 'package:trivia_quiz/util/load_questions.dart';
import 'package:trivia_quiz/util/loading_screen.dart';
import 'package:trivia_quiz/util/question_with_answers.dart';
import 'dart:async';

import 'package:trivia_quiz/util/time_format.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.difficulty, required this.label});

  final String difficulty;
  final String label;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuestionWithAnswers> questions = [];
  int currentIndex = 0;

  late final Timer timer;
  int seconds = 120;

  @override
  void initState() {
    fetchQuestions().then((value) {
      setState(() {
        startTimer();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> fetchQuestions() async {
    questions.addAll(await getQuestions(widget.difficulty));
  }

  void getNextQuestion() {
    setState(() {
      currentIndex++;
    });

    if (currentIndex > questions.length - 10) {
      fetchQuestions();
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (seconds == 0) {
          timer.cancel();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultScreen(
                      points: currentIndex, difficulty: widget.difficulty)));
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Confirm Action"),
                  content: const Text("Your progress will be lost!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Confirm"))
                  ],
                ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mode: "${widget.label}"'),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.merge(const TextStyle(color: Colors.green)),
                    formatTime(seconds)),
              ),
            )
          ],
        ),
        body: currentIndex == questions.length
            ? const LoadingScreen()
            : Question(
                question: questions[currentIndex],
                getNextQuestion: getNextQuestion,
                index: currentIndex,
              ),
      ),
    );
  }
}
