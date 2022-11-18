import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_quiz/home_screen/mode_card.dart';
import 'package:trivia_quiz/quiz_screen/quiz_screen.dart';
import 'package:trivia_quiz/util/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final difficulties = {"easy": "Easy", "medium": "Medium", "hard": "Hard"};

  Map<String, int>? highscores;

  Future<void> onModeSelected(String difficulty) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => QuizScreen(
                  difficulty: difficulty,
                  label: difficulties[difficulty]!,
                ))));

    getHighscores().then((value) {
      setState(() {
        highscores = value;
      });
    });
  }

  @override
  void initState() {
    getHighscores().then((value) {
      setState(() {
        highscores = value;
      });
    });
    super.initState();
  }

  Future<Map<String, int>> getHighscores() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, int> highscores = {};

    for (final difficulty in difficulties.keys) {
      highscores[difficulty] = prefs.getInt("highscore_$difficulty") ?? 0;
    }

    return highscores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: highscores == null
          ? const LoadingScreen()
          : Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                constraints:
                    const BoxConstraints(maxWidth: 400, maxHeight: 400),
                child: Column(
                  children: difficulties.entries
                      .map((e) => ModeCard(
                            difficulty: e.key,
                            label: e.value,
                            onPress: onModeSelected,
                            highscore: (highscores?[e.key])!,
                          ))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
