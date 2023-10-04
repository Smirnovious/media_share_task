import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'User';
  }

  static Future<void> setMediaDescription({
    required String fileName,
    required String description,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(fileName, description);
  }

  static Future<String?> getMediaDescription(String fileName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fileName);
  }
}
