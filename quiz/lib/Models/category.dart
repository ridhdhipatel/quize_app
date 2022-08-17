// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
    Categories({
        this.triviaCategories,
    });

    List<TriviaCategory>? triviaCategories;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        triviaCategories: List<TriviaCategory>.from(json["trivia_categories"].map((x) => TriviaCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "trivia_categories": List<dynamic>.from(triviaCategories!.map((x) => x.toJson())),
    };
}

class TriviaCategory {
    TriviaCategory({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory TriviaCategory.fromJson(Map<String, dynamic> json) => TriviaCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
