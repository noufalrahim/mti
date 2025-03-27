import 'dart:convert';
import 'package:milestone_tracker_of_infants/core/constants/constants.dart';
import 'package:milestone_tracker_of_infants/models/question_model.dart';
import 'package:http/http.dart' as http;

class QuestionRepository {

  Future<List<QuestionModel>> getQuestionsByCategory(int categoryId) async {
    try {
      final res = await http.get(
        Uri.parse("${Constants.backendUri}/questions/$categoryId"),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(utf8.decode(res.bodyBytes));
      }

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(res.bodyBytes),
      );

      if (!responseData.containsKey("data") || responseData["data"] is! List) {
        throw Exception("Invalid response format");
      }

      List<QuestionModel> questionsList =
          (responseData["data"] as List)
              .map<QuestionModel>((elem) => QuestionModel.fromMap(elem))
              .toList();

      return questionsList;
    } catch (e) {
      print("Error fetching questions: $e");
      rethrow;
    }
  }
}
