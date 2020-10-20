import 'package:Retailer/models/bookslots.dart';
import 'package:Retailer/models/categorysubmit.dart';
import 'package:Retailer/models/getallslots.dart';
import 'package:Retailer/models/categories.dart';
import 'package:Retailer/models/holidayresponse.dart';
import 'package:Retailer/models/nearshop.dart';
import 'package:Retailer/models/registeuser.dart';
import 'package:Retailer/models/retailerallbookings.dart';
import 'package:Retailer/models/shopslotresponse.dart';
import 'package:Retailer/models/verifycoderesult.dart';
import 'package:Retailer/service/uploadphoto.dart';

import 'api_client.dart';

class APIRepository {
  //https://medium.com/flutter-community/flutter-essential-what-you-need-to-know-567ad25dcd8f
//https://flutter.dev/docs/cookbook/networking/fetch-data
//https://github.com/PoojaB26/ParsingJSON-Flutter/blob/master/lib/main.dart
//https://www.tutorialspoint.com/flutter/flutter_accessing_rest_api.htm
//https://github.com/rodydavis/flutter_login
// https://github.com/myvsparth/flutter_rest_api

  final ShopApiClient shopApiClient;

  APIRepository(this.shopApiClient);

  Future<RetailerregisterResponse> registerRetailer(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.registerRetailer(requestMap);
  }

  Future<CategoryResponse> categoryList() async {
    return await shopApiClient.getCategoryList();
  }

  Future<CategorySubmitResponse> submitShopCategory(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.submitCategory(requestMap);
  }

  Future<CategorySubmitResponse> submitShopTimeSlot(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.submitTimeSlot(requestMap);
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

  Future<ShopCertificateResponse> uploadShopCerificate(
      {retailerId, imagePath}) async {
    return await shopApiClient.uploadShopCerificate(retailerId, imagePath);
  }

  Future<RetailerbookingResponse> getAllbooking(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.getAllbooking(requestMap);
  }

  Future<VerifyCodeResponse> verifyUserCode(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.verifyUserCode(requestMap);
  }

  Future<ShopuserslotResponse> updatetimeslot(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.updatetimeslot(requestMap);
  }

  Future<Holidayresponse> enableholiday(
      {Map<String, dynamic> requestMap}) async {
    return await shopApiClient.enableholiday(requestMap);
  }
}
