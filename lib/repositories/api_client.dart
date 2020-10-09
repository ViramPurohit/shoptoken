import 'dart:convert';

import 'package:Retailer/models/registeuser.dart';
import 'package:Retailer/models/bookslots.dart';
import 'package:Retailer/models/getallslots.dart';
import 'package:Retailer/models/categories.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:Retailer/models/nearshop.dart';
import 'package:Retailer/models/registeuser.dart';
import 'package:Retailer/service/uploadphoto.dart';

class ShopApiClient {
  String _baseUrl = 'https://inline.pythonanywhere.com';
  // new URL

  static const Map<String, String> _json_header = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<RetailerregisterResponse> registerRetailer(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/register/retailer';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return RetailerregisterResponse.fromJson(json.decode(response.body));
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

  Future<CategoryResponse> submitCategory(
      Map<String, dynamic> requestMap) async {
    var url = '$_baseUrl/retailercategory';

    final response = await http.post(url,
        headers: _json_header, body: json.encode(requestMap));

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

  Future<ShopCertificateResponse> uploadShopCerificate(
      retailerId, imagePath) async {
    var url = '$_baseUrl/uploadshopcertificate';

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['retailer_id'] = retailerId;
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    var response = await request.send();

    print(" response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final respStr = await response.stream.bytesToString();
      print(respStr);
      // return compute(parseCertificate, response.reasonPhrase);
      return ShopCertificateResponse.fromJson(json.decode(respStr));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  ShopCertificateResponse parseCertificate(String responseBody) {
    return ShopCertificateResponse.fromJson(json.decode(responseBody));
  }
}
