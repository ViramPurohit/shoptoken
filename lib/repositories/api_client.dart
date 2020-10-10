import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:http/http.dart' as http;
import 'package:shoptoken/models/nearshop.dart';
import 'package:shoptoken/models/registeuser.dart';
import 'package:shoptoken/service/uploadphoto.dart';

class ShopApiClient {
  String _baseUrl = 'https://inline.pythonanywhere.com';
  // new URL

  static const Map<String, String> _json_header = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<RegisterUser> registerUser(Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/register/customer';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return RegisterUser.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
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

  Future<NearShopResponse> getNearShop() async {
    var url = '$_baseUrl/getnearshop';

    final response = await http.get(url);

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
}
