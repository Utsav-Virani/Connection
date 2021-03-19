import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static String _userSigninKey = "ISUSERSIGNEDIN";
  static String _userNameKey = "USERNAME";
  static String _userEmailKey = "USEREMAIL";

  static Future<bool> setUserSignInPreference(bool _isloggiedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_userSigninKey, _isloggiedIn);
  }

  static Future<bool> setUserNamePreference(String _userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userNameKey, _userName);
  }

  static Future<bool> setUserEmailPreference(String _userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userEmailKey, _userEmail);
  }

  static Future<bool> getUserSignInPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userSigninKey);
  }

  static Future<String> getUserEmailPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<String> getUserNamePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }
}
