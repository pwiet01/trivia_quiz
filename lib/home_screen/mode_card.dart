import 'dart:ui';

import 'package:flutter/material.dart';

class ModeCard extends StatelessWidget {
  const ModeCard(
      {super.key,
      required this.difficulty,
      required this.label,
      required this.onPress,
      required this.highscore});

  final int highscore;
  final String difficulty;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: InkWell(
          onTap: () => onPress(difficulty),
          child: Card(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      style: Theme.of(context).textTheme.headlineMedium, label),
                  const SizedBox(height: 5),
                  Text(
                      style: const TextStyle(fontStyle: FontStyle.italic),
                      "Highscore: ${highscore.toString()}")
                ],
              ),
            )),
          ),
        ))
      ],
    ));
  }
}
