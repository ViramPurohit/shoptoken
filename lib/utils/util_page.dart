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
}
