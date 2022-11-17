import 'package:flutter/material.dart';

class LoadingBar extends StatefulWidget {
  const LoadingBar(
      {super.key, required this.duration, required this.handleFinish});

  final int duration;
  final Function handleFinish;

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        reverseDuration: Duration(seconds: widget.duration),
        value: 1.0)
      ..addListener(() {
        setState(() {});
      });
    animate();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void animate() async {
    await controller.reverse();
    widget.handleFinish();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
    );
  }
}
