class NearShopResponse {
  Nearshopresult nearshopresult;

  NearShopResponse({this.nearshopresult});

  NearShopResponse.fromJson(Map<String, dynamic> json) {
    nearshopresult = json['nearshopresult'] != null
        ? new Nearshopresult.fromJson(json['nearshopresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearshopresult != null) {
      data['nearshopresult'] = this.nearshopresult.toJson();
    }
    return data;
  }
}

class Nearshopresult {
  List<NearshopData> data;
  int isError;
  String message;

  Nearshopresult({this.data, this.isError, this.message});

  Nearshopresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<NearshopData>();
      json['data'].forEach((v) {
        data.add(new NearshopData.fromJson(v));
      });
    }
    isError = json['isError'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['isError'] = this.isError;
    data['message'] = this.message;
    return data;
  }
}

class NearshopData {
  String address;
  String endAt;
  int id;
  int isCloseToday;
  String mobileNo;
  String shopName;
  String startAt;
  String url;

  NearshopData(
      {this.address,
      this.endAt,
      this.id,
      this.isCloseToday,
      this.mobileNo,
      this.shopName,
      this.startAt,
      this.url});

  NearshopData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    endAt = json['end_at'];
    id = json['id'];
    isCloseToday = json['isCloseToday'];
    mobileNo = json['mobile_no'];
    shopName = json['shop_name'];
    startAt = json['start_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['end_at'] = this.endAt;
    data['id'] = this.id;
    data['isCloseToday'] = this.isCloseToday;
    data['mobile_no'] = this.mobileNo;
    data['shop_name'] = this.shopName;
    data['start_at'] = this.startAt;
    data['url'] = this.url;
    return data;
  }
}
