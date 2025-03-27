import 'dart:convert';

import 'package:milestone_tracker_of_infants/core/constants/constants.dart';
import 'package:milestone_tracker_of_infants/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final res = await http.get(
        Uri.parse("${Constants.backendUri}/category"),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body);
      }

      final listOfCategories = jsonDecode(res.body);
      List<CategoryModel> categoriesList = [];

      for (var elem in listOfCategories) {
        categoriesList.add(CategoryModel.fromMap(elem));
      }

      return categoriesList;
    } catch (e) {
      rethrow;
    }
  }
}
