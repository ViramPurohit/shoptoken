import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoptoken/models/registeuser.dart';

class Apppreferences {
  addUserLogin(RegisterUser result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.setInt('userId', result.id);
    prefs.setString('username', result.fullName);
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
