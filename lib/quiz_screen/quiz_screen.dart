import 'package:flutter/material.dart';
import 'package:trivia_quiz/quiz_screen/question.dart';
import 'package:trivia_quiz/util/load_questions.dart';
import 'package:trivia_quiz/util/loading_screen.dart';
import 'package:trivia_quiz/util/question_with_answers.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.difficulty});

  final String difficulty;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuestionWithAnswers> questions = [];
  int currentIndex = 0;

  @override
  void initState() {
    fetchQuestions().then((value) => setState(() {}));
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return currentIndex == questions.length
        ? const LoadingScreen()
        : Question(
            question: questions[currentIndex],
            getNextQuestion: getNextQuestion);
  }
}
