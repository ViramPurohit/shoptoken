class RetailerregisterResponse {
  RetailerregisterResult retailerregisterResult;

  RetailerregisterResponse({this.retailerregisterResult});

  RetailerregisterResponse.fromJson(Map<String, dynamic> json) {
    retailerregisterResult = json['retailerregisterResult'] != null
        ? new RetailerregisterResult.fromJson(json['retailerregisterResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailerregisterResult != null) {
      data['retailerregisterResult'] = this.retailerregisterResult.toJson();
    }
    return data;
  }
}

class RetailerregisterResult {
  String address;
  int id;
  int isError;
  String message;
  String mobileNo;
  String shopName;

  RetailerregisterResult(
      {this.address,
      this.id,
      this.isError,
      this.message,
      this.mobileNo,
      this.shopName});

  RetailerregisterResult.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    isError = json['isError'];
    message = json['message'];
    mobileNo = json['mobile_no'];
    shopName = json['shop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['isError'] = this.isError;
    data['message'] = this.message;
    data['mobile_no'] = this.mobileNo;
    data['shop_name'] = this.shopName;
    return data;
  }
}
