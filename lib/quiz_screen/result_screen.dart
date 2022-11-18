import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_quiz/util/loading_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {super.key, required this.points, required this.difficulty});

  final int points;
  final String difficulty;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int? highscore;

  @override
  void initState() {
    getHighscore().then((value) {
      setState(() {
        highscore = value;
      });
    });
    super.initState();
  }

  Future<int> getHighscore() async {
    final prefs = await SharedPreferences.getInstance();
    final highscore = prefs.getInt("highscore_${widget.difficulty}") ?? 0;

    if (highscore < widget.points) {
      await prefs.setInt("highscore_${widget.difficulty}", widget.points);
    }

    return highscore;
  }

  @override
  Widget build(BuildContext context) {
    final isNewHighscore = (highscore ?? 0) < widget.points;
    final labels = [
      "Points:",
      isNewHighscore ? "Old Highscore:" : "Highscore:"
    ];
    final values = [widget.points, highscore];

    Future<bool> onWillPop() async {
      Navigator.popUntil(context, (route) => route.isFirst);
      return false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(title: const Text("Results")),
        body: highscore == null
            ? const LoadingScreen()
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isNewHighscore
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.merge(const TextStyle(color: Colors.green)),
                              "New Highscore!"),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: labels
                            .map((e) => Text(
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.merge(const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                e))
                            .toList(),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: values
                            .map((e) => Text(
                                style: Theme.of(context).textTheme.headline6,
                                e.toString()))
                            .toList(),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: TextButton(
                      child: const Text(style: TextStyle(fontSize: 20), "Home"),
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                    ),
                  )
                ],
              )),
      ),
    );
  }
}
