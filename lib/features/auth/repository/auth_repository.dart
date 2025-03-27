import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:milestone_tracker_of_infants/core/constants/constants.dart';
import 'package:milestone_tracker_of_infants/models/user_model.dart';

class AuthRepository {
  Future<UserModel> signUp({required String phone}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.backendUri}/auth"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(jsonDecode(response.body)['message'] ?? "Signup failed");
      }

      final decodedResponse = jsonDecode(response.body);
      if (!decodedResponse.containsKey('data')) {
        throw Exception("Invalid response format: Missing 'data' field");
      }

      print(decodedResponse);
      final Map<String, dynamic> userData = decodedResponse['data'];
      await _saveUserToLocalStorage(userData);
      print(userData);
      return UserModel.fromMap(userData);
    } catch (error) {
      print("Signup Error: $error");
      rethrow;
    }
  }

  Future<void> _saveUserToLocalStorage(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(userData);
    await prefs.setString('loggedInUser', jsonString);
  }

  Future<UserModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('loggedInUser');

    if (jsonString == null) return null;
    
    final Map<String, dynamic> userData = jsonDecode(jsonString);
    return UserModel.fromMap(userData);
  }
}
