import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Models/api_response.dart';
import '../Models/category.dart';
import '../Models/quiz.dart';

class QuizService {
  static const String baseUrl = 'https://opentdb.com/';

  var quizList = Quiz();

  Future<APIResponse<Quiz>> getQuizList(
      int categoryId, String difficulty) async {
    try {
      return await http
          .get(Uri.parse(
              '${baseUrl}api.php?amount=10&category=$categoryId&difficulty=$difficulty&type=multiple&'))
          .then((response) {
        if (response.statusCode == 200) {
          final quizList = quizFromJson(response.body);
          debugPrint(quizList.results.toString());

          return APIResponse<Quiz>(data: quizList);
        } else {
          return APIResponse<Quiz>(error: true, errorMessage: 'An error occur');
        }
      }).catchError((error) {
        return APIResponse<Quiz>(
            error: true, errorMessage: '$error An error occured.');
      });
    } catch (ex) {
      return APIResponse<Quiz>(
          error: true, errorMessage: '$ex An error occured.');
    }
  }
}
