import 'dart:convert';

import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:http/http.dart' as http;
import 'package:shoptoken/models/registeuser.dart';

class ShopApiClient {
  String _baseUrl = 'https://reqres.in/api';

  Future<RegisterUser> registerUser() async {
    var url = '$_baseUrl/register';

    final response = await http.get(url);

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
    var url = '$_baseUrl/users/?page=2';

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

  Future<GetAllSlotsResponse> getBookSlotList() async {
    var url = '$_baseUrl/unknown';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return GetAllSlotsResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<BookSlotsResponse> bookSlot() async {
    var url = '$_baseUrl/unknown/2';

    final response = await http.get(url);

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
