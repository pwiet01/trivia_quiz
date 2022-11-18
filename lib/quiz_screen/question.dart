import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trivia_quiz/util/question_with_answers.dart';

import 'answer.dart';
import 'loading_bar.dart';

class Question extends StatefulWidget {
  const Question(
      {super.key,
      required this.question,
      required this.getNextQuestion,
      required this.index});

  final QuestionWithAnswers question;
  final Function getNextQuestion;
  final int index;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  var answerStates = <int, Color>{};
  var loading = false;
  var buttonsDisabled = false;

  void getNextQuestion() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        widget.getNextQuestion();
        answerStates = {};
        buttonsDisabled = false;
      });
    });
  }

  void chooseAnswer(int index) {
    if (!loading && !buttonsDisabled) {
      if (index == widget.question.correctIndex) {
        setState(() {
          answerStates[index] = Colors.green;
        });

        buttonsDisabled = true;
        getNextQuestion();
      } else {
        setState(() {
          answerStates[index] = Colors.red;
          loading = true;
        });
      }
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
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Text(
                                style: Theme.of(context).textTheme.headline6,
                                widget.question.question)),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: Text((widget.index + 1).toString()))
                    ]),
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
