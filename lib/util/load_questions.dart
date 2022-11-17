import 'dart:convert';

import 'package:trivia_quiz/util/question_with_answers.dart';
import 'package:http/http.dart' as http;

Future<List<QuestionWithAnswers>> getQuestions(String difficulty) async {
  final response = await http.get(Uri.parse(
      "https://opentdb.com/api.php?amount=50&difficulty=$difficulty&type=multiple"));

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    if (body["response_code"] != 0) {
      throw Exception("Failed to load questions");
    }

    return List<QuestionWithAnswers>.from(
        body["results"].map((q) => QuestionWithAnswers(q)));
  } else {
    throw Exception("Failed to load questions");
  }
}
