import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Util {
  // ignore: unused_element
  static Future<bool> _phoneNumberValidator(String value) async {
    Pattern pattern = r'^[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  String validateName(String value) {
    if (value.length == 0) {
      return "Name is Required";
    }
    return null;
  }

  static void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<String> getDeviceOS() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      return iosInfo.systemVersion;
    }
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    return packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
  }
}
