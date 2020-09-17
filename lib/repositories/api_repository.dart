import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/models/registeuser.dart';

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

  Future<RegisterUser> registerUser({Map<String, dynamic> requestMap}) async {
    return await shopApiClient.registerUser(requestMap);
  }

  Future<CategoryResponse> categoryList() async {
    return await shopApiClient.getCategoryList();
  }

  Future<GetAllSlotsResponse> getBookSlotList() async {
    return await shopApiClient.getBookSlotList();
  }

  Future<BookSlotsResponse> bookSlot() async {
    return await shopApiClient.bookSlot();
  }
}
