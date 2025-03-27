import 'dart:convert';

import 'package:milestone_tracker_of_infants/core/constants/constants.dart';
import 'package:http/http.dart' as http;

class ChildResponseRepository {
  Future<dynamic> getProgressOfChild(final childId) async {
    try {
      final res = await http.get(
        Uri.parse('${Constants.backendUri}/childresponses/$childId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if(res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      final progressList = jsonDecode(res.body)['data'];
      return progressList;

    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addChildResponse(
    final int questionId,
    final bool answer,
    final int childId,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("${Constants.backendUri}/childresponses/add"),
        headers: {'Content-Type': 'application/json',},
        body: jsonEncode({
          'question': {
            'id': questionId,
          },
          'questionAnswered': true,
          'answeredYes': answer ? answer : 0,
          'child': {
            'id': childId
          },
        }),
      );
       if (res.statusCode != 200) {
        throw jsonDecode(res.body)['error'];
      }
      final childResponse = jsonDecode(res.body)['data'];
      return childResponse;
    }
    catch (e) {
      rethrow;
    }
  }
}
