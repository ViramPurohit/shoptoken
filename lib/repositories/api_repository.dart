import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/customerloginrespone.dart';
import 'package:shoptoken/models/customerregister.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/models/nearshop.dart';
import 'package:shoptoken/models/resetcustomerrespone.dart';
import 'package:shoptoken/models/verifycustomerrespone.dart';

import 'api_client.dart';

class APIRepository {
  final ShopApiClient shopApiClient;

  APIRepository(this.shopApiClient);

  Future<CustomerRegisterResponse> registerUser(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.registerUser(requestMap);
  }

  Future<Customerloginresponse> logincustomer(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.logincustomer(requestMap);
  }

  Future<Verifycustomerresponse> verifycustomermobile(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.verifycustomermobile(requestMap);
  }

  Future<Resetcustomerresponse> resetcustomerpassword(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.resetcustomerpassword(requestMap);
  }

  Future<CategoryResponse> categoryList() async {
    return await shopApiClient.getCategoryList();
  }

  Future<NearShopResponse> getNearShop() async {
    return await shopApiClient.getNearShop();
  }

  Future<GetAllSlotsResponse> geSlotList(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.geSlotList(requestMap);
  }

  Future<BookSlotsResponse> bookSlot({Map<String, dynamic> requestMap}) async {
    return await shopApiClient.bookSlot(requestMap);
  }
}
