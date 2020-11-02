import 'package:shared_preferences/shared_preferences.dart';

class Apppreferences {
  clearApppreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  addUserLogin(id, fullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.setInt('userId', id);
    prefs.setString('fullName', fullName);
  }

  Future<String> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fullName = prefs.getString('fullName');
    return fullName;
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('userId');
    return userId;
  }

  Future<bool> isUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool boolValue = prefs.getBool('isLogin');
    return boolValue;
  }

  addAppToken(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', fcmToken);
  }

  Future<String> getAppToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _appToken = prefs.getString('token');
    return _appToken;
  }
}
