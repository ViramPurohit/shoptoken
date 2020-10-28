import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/models/nearshop.dart';
import 'package:shoptoken/models/registeuser.dart';

import 'api_client.dart';

class APIRepository {
  final ShopApiClient shopApiClient;

  APIRepository(this.shopApiClient);

  Future<RegisterUser> registerUser({Map<String, dynamic> requestMap}) async {
    return await shopApiClient.registerUser(requestMap);
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
