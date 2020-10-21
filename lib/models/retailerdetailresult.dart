class RetailerdetailResponse {
  Retailerdetailresult retailerdetailresult;

  RetailerdetailResponse({this.retailerdetailresult});

  RetailerdetailResponse.fromJson(Map<String, dynamic> json) {
    retailerdetailresult = json['retailerdetailresult'] != null
        ? new Retailerdetailresult.fromJson(json['retailerdetailresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailerdetailresult != null) {
      data['retailerdetailresult'] = this.retailerdetailresult.toJson();
    }
    return data;
  }
}

class Retailerdetailresult {
  List<Data> data;
  int isError;
  String message;

  Retailerdetailresult({this.data, this.isError, this.message});

  Retailerdetailresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  String address;
  String endAt;
  String fullName;
  String mobileNo;
  String shopLicense;
  String shopName;
  String startAt;
  String url;

  Data(
      {this.address,
      this.endAt,
      this.fullName,
      this.mobileNo,
      this.shopLicense,
      this.shopName,
      this.startAt,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    endAt = json['end_at'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
    shopLicense = json['shop_license'];
    shopName = json['shop_name'];
    startAt = json['start_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['end_at'] = this.endAt;
    data['full_name'] = this.fullName;
    data['mobile_no'] = this.mobileNo;
    data['shop_license'] = this.shopLicense;
    data['shop_name'] = this.shopName;
    data['start_at'] = this.startAt;
    data['url'] = this.url;
    return data;
  }
}
