import 'dart:math';
import 'package:html_unescape/html_unescape.dart';

class QuestionWithAnswers {
  final Map<String, dynamic> apiResultItem;

  late final String question;
  late final List<String> answers;
  late final int correctIndex;

  QuestionWithAnswers(this.apiResultItem) {
    final unescape = HtmlUnescape();
    question = unescape.convert(apiResultItem["question"]);
    answers = [
      ...apiResultItem["incorrect_answers"]
          .map((item) => unescape.convert(item))
    ];
    answers.shuffle();
    correctIndex = Random().nextInt(4);
    answers.insert(
        correctIndex, unescape.convert(apiResultItem["correct_answer"]));
  }
}
