class Retailerloginrespone {
  Retailerloginresult retailerloginresult;

  Retailerloginrespone({this.retailerloginresult});

  Retailerloginrespone.fromJson(Map<String, dynamic> json) {
    retailerloginresult = json['retailerloginresult'] != null
        ? new Retailerloginresult.fromJson(json['retailerloginresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailerloginresult != null) {
      data['retailerloginresult'] = this.retailerloginresult.toJson();
    }
    return data;
  }
}

class Retailerloginresult {
  String address;
  int id;
  int isError;
  String message;
  String mobileNo;
  String shopName;

  Retailerloginresult(
      {this.address,
      this.id,
      this.isError,
      this.message,
      this.mobileNo,
      this.shopName});

  Retailerloginresult.fromJson(Map<String, dynamic> json) {
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
