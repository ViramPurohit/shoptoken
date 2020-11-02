import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/models/customerloginrespone.dart';
import 'package:shoptoken/models/customerregister.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/models/getcustomerdetailresponse.dart';
import 'package:shoptoken/models/getfavoriteresponse.dart';
import 'package:shoptoken/models/nearshop.dart';
import 'package:shoptoken/models/resetcustomerrespone.dart';
import 'package:shoptoken/models/userfavoriteresponse.dart';
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

  Future<NearShopResponse> getNearShop(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.getNearShop(requestMap);
  }

  Future<GetAllSlotsResponse> geSlotList(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.geSlotList(requestMap);
  }

  Future<BookSlotsResponse> bookSlot({Map<String, dynamic> requestMap}) async {
    return await shopApiClient.bookSlot(requestMap);
  }

  Future<GetCustomerdetailresponse> getcustomerdetail(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.getcustomerdetail(requestMap);
  }

  Future<Customerbookingresponse> getallcustomerbooking(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.getallcustomerbooking(requestMap);
  }

  Future<Userfavoriteresponse> addtofavorite(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.addtofavorite(requestMap);
  }

  Future<Getfavoriteresponse> getfavoriteretailer(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.getfavoriteretailer(requestMap);
  }
}
