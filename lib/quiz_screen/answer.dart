import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(
      {super.key,
      required this.bgColor,
      required this.handleTap,
      required this.text});

  final Color? bgColor;
  final Function handleTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () => handleTap(),
      child: Card(
        color: bgColor ?? Colors.white,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(text),
        )),
      ),
    ));
  }
}
