import 'package:shared_preferences/shared_preferences.dart';

class Apppreferences {
  addUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
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
