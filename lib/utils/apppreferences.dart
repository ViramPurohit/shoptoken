import 'package:shared_preferences/shared_preferences.dart';
import 'package:Retailer/models/registeuser.dart';

class Apppreferences {
  clearApppreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  addUserLogin(id, shopName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id);
    prefs.setString('shopname', shopName);
  }

  addSignupLevel(level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("signuplevel", level);
  }

  addLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('userId');
    return userId;
  }

  Future<String> getShopName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('shopname');
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
