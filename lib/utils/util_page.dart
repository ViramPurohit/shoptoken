import 'package:flutter/material.dart';

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
}
