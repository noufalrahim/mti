import 'dart:convert';

import 'package:milestone_tracker_of_infants/core/constants/constants.dart';
import 'package:milestone_tracker_of_infants/models/child_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChildRepository {
  Future<List<ChildModel>> getChildrenByUser(final id) async {
    try {
      final res = await http.get(
        Uri.parse('${Constants.backendUri}/child/user/${id.toString()}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      final listOfChildren = jsonDecode(res.body)['data'];
      List<ChildModel> childrenList = [];
      for (var elem in listOfChildren) {
        childrenList.add(ChildModel.fromMap(elem));
      }
      return childrenList;
    } catch (e) {
      rethrow;
    }
  }

  Future<ChildModel> getDefaultChild(final userId) async {
    try {
      final res = await http.get(
        Uri.parse(
          '${Constants.backendUri}/users/default-child/${userId.toString()}',
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      final Map<String, dynamic> data = jsonDecode(res.body)['data'];
      return ChildModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editDefaultChild(int userId, int childId) async {
    try {
      final res = await http.put(
        Uri.parse(
          '${Constants.backendUri}/users/$userId/default-child/$childId',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      print("Added default child");
    } catch (e) {
      rethrow;
    }
  }

  Future<ChildModel> addChild({
    required dynamic name,
    required dynamic dob,
    required dynamic isPremature,
    required dynamic weeksOfPremature,
    required dynamic userId,
  }) async {
    try {
      DateTime parsedDob;

      // Ensure dob is in a valid format before parsing
      if (dob is String) {
        // Detect format and parse accordingly
        if (RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(dob)) {
          parsedDob = DateFormat('MM/dd/yyyy').parse(dob);
        } else if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dob)) {
          parsedDob = DateTime.parse(dob); // Direct parsing for yyyy-MM-dd
        } else {
          throw FormatException(
            "Invalid date format. Expected 'MM/dd/yyyy' or 'yyyy-MM-dd'",
          );
        }
      } else {
        parsedDob = dob as DateTime;
      }

      String formattedDob = DateFormat('yyyy-MM-dd').format(parsedDob);

      final res = await http.post(
        Uri.parse("${Constants.backendUri}/child/add"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "dateOfBirth": formattedDob,
          "isPremature": isPremature,
          "weekOfPrematurity": weeksOfPremature,
          "user": {"id": userId},
        }),
      );
      print(res.statusCode);
      if (res.statusCode != 201) {
        print("err: ${jsonDecode(res.body)['message']}");
        throw jsonDecode(res.body)['message'];
      }

      final Map<String, dynamic> data = jsonDecode(res.body)['data'];
      final childData = ChildModel.fromJson(data);
      await editDefaultChild(userId, childData.id);

      return childData;
    } catch (e) {
      print("Error adding child: $e");
      rethrow;
    }
  }
}
