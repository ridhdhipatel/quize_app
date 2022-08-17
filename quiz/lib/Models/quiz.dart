import 'dart:convert';
import 'dart:convert';

Quiz quizFromJson(String str) => Quiz.fromJson(json.decode(str));

String quizToJson(Quiz data) => json.encode(data.toJson());

class Quiz {
  Quiz({
    this.responseCode,
    this.results,
  });

  int? responseCode;
  List<Result>? results;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        responseCode: json["response_code"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: json["category"],
        type: json["type"],
        difficulty: json["difficulty"],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "type": type,
        "difficulty": difficulty,
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers":
            List<dynamic>.from(incorrectAnswers!.map((x) => x)),
      };
}

enum Difficulty {
  // ignore: constant_identifier_names
  Easy,
  // ignore: constant_identifier_names
  Medium,
  // ignore: constant_identifier_names
  Hard
}
