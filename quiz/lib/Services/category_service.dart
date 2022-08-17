
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Models/api_response.dart';
import '../Models/category.dart';

class CategoryService {
  static const String baseUrl = 'https://opentdb.com/';
  final categories = Categories();

  Future<APIResponse<Categories>> getCategoriesList() async {
    try {
      return await http
          .get(Uri.parse('${baseUrl}api_category.php'))
          .then((response) {
        if (response.statusCode == 200) {
          final categoriesList = categoriesFromJson(response.body);
          debugPrint(categoriesList.toString());

          return APIResponse<Categories>(data: categoriesList);
        } else {
          return APIResponse<Categories>(
              error: true, errorMessage: 'An error occur');
        }
      }).catchError((error) {
        return APIResponse<Categories>(
            error: true, errorMessage: '$error An error occured.');
      });
    } catch (ex) {
      return APIResponse<Categories>(
          error: true, errorMessage: '$ex An error occured.');
    }
  }
}
