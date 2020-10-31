import 'dart:convert';

import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/models/customerloginrespone.dart';
import 'package:shoptoken/models/customerregister.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:http/http.dart' as http;
import 'package:shoptoken/models/getcustomerdetailresponse.dart';
import 'package:shoptoken/models/getfavoriteresponse.dart';
import 'package:shoptoken/models/nearshop.dart';
import 'package:shoptoken/models/resetcustomerrespone.dart';
import 'package:shoptoken/models/userfavoriteresponse.dart';
import 'package:shoptoken/models/verifycustomerrespone.dart';

class ShopApiClient {
  String _baseUrl = 'https://inline.pythonanywhere.com';
  // new URL

  static const Map<String, String> _json_header = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<CustomerRegisterResponse> registerUser(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/register/customer';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return CustomerRegisterResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Customerloginresponse> logincustomer(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/logincustomer';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return Customerloginresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Verifycustomerresponse> verifycustomermobile(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/verifycustomermobile';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Verifycustomerresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load api');
    }
  }

  Future<Resetcustomerresponse> resetcustomerpassword(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/resetcustomerpassword';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Resetcustomerresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load api');
    }
  }

  Future<CategoryResponse> getCategoryList() async {
    var url = '$_baseUrl/getcategorymaster';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return CategoryResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<NearShopResponse> getNearShop(Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/getnearshop';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return NearShopResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<GetAllSlotsResponse> geSlotList(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/getslotmaster';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return GetAllSlotsResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load api');
    }
  }

  Future<BookSlotsResponse> bookSlot(Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/bookslot';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return BookSlotsResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<GetCustomerdetailresponse> getcustomerdetail(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/getcustomerdetail';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return GetCustomerdetailresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Customerbookingresponse> getallcustomerbooking(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/getallcustomerbooking';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));
    print(url);
    print(requestMap.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Customerbookingresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  Future<Userfavoriteresponse> addtofavorite(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/addtofavorite';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));
    print(url);
    print(requestMap.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Userfavoriteresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  Future<Getfavoriteresponse> getfavoriteretailer(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/getfavoriteretailer';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));
    print(url);
    print(requestMap.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Getfavoriteresponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }
}
