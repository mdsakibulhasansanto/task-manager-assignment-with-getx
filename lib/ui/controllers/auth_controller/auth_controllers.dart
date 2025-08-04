
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user_models.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;

  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  // Save user model & token to SharedPreferences
  static Future<void> saveUserData(String token, UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userJson = jsonEncode(model.toJson());

    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_userDataKey, userJson);

    accessToken = token;
    userModel = model;
  }

  // Load user model & token from SharedPreferences
  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    accessToken = prefs.getString(_accessTokenKey);
    final String? userDataString = prefs.getString(_userDataKey);

    if (userDataString != null && userDataString.isNotEmpty) {
      try {
        Map<String, dynamic> userMap = jsonDecode(userDataString);
        userModel = UserModel.fromJson(userMap);
        print(' UserModel loaded: $userModel');
      } catch (e) {
        print(' Error decoding userModel: $e');
        userModel = null;
      }
    } else {
      print(' No user data found');
      userModel = null;
    }
  }

  // Check login status
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_accessTokenKey);

    if (token != null && token.isNotEmpty) {
      await getUserData();
      return true;
    }
    return false;
  }

  // Clear all user data on logout
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    accessToken = null;
    userModel = null;
    print('Cleared all SharedPreferences data');
  }
}
