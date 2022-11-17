import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trivia_quiz/util/question_with_answers.dart';

import 'answer.dart';
import 'loading_bar.dart';

class Question extends StatefulWidget {
  const Question(
      {super.key, required this.question, required this.getNextQuestion});

  final QuestionWithAnswers question;
  final Function getNextQuestion;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  var answerStates = <int, Color>{};
  var loading = false;

  void getNextQuestion() {
    Timer(const Duration(milliseconds: 500), () {
      widget.getNextQuestion();
      answerStates = {};
    });
  }

  void chooseAnswer(int index) {
    if (!loading) {
      setState(() {
        if (index == widget.question.correctIndex) {
          answerStates[index] = Colors.green;
          getNextQuestion();
        } else {
          answerStates[index] = Colors.red;
          loading = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
        child: Column(children: [
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: Card(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(widget.question.question),
                    )),
                  ))
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Answer(
                      bgColor: answerStates[0],
                      handleTap: () => chooseAnswer(0),
                      text: widget.question.answers[0]),
                  Answer(
                      bgColor: answerStates[1],
                      handleTap: () => chooseAnswer(1),
                      text: widget.question.answers[1])
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Answer(
                      bgColor: answerStates[2],
                      handleTap: () => chooseAnswer(2),
                      text: widget.question.answers[2]),
                  Answer(
                      bgColor: answerStates[3],
                      handleTap: () => chooseAnswer(3),
                      text: widget.question.answers[3])
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: 5,
              child: loading
                  ? LoadingBar(
                      duration: 3,
                      handleFinish: () {
                        setState(() {
                          loading = false;
                        });
                      })
                  : Container(),
            ),
          )
        ]),
      ),
    );
  }
}
