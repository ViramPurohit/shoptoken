class Getfavoriteresponse {
  Getfavoriteresult getfavoriteresult;

  Getfavoriteresponse({this.getfavoriteresult});

  Getfavoriteresponse.fromJson(Map<String, dynamic> json) {
    getfavoriteresult = json['getfavoriteresult'] != null
        ? new Getfavoriteresult.fromJson(json['getfavoriteresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getfavoriteresult != null) {
      data['getfavoriteresult'] = this.getfavoriteresult.toJson();
    }
    return data;
  }
}

class Getfavoriteresult {
  List<FavoriteData> data;
  int isError;
  String message;

  Getfavoriteresult({this.data, this.isError, this.message});

  Getfavoriteresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<FavoriteData>();
      json['data'].forEach((v) {
        data.add(new FavoriteData.fromJson(v));
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

class FavoriteData {
  String address;
  int customerId;
  String isBooked;
  int retailerId;
  String shopName;

  FavoriteData(
      {this.address,
      this.customerId,
      this.isBooked,
      this.retailerId,
      this.shopName});

  FavoriteData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    customerId = json['customer_id'];
    isBooked = json['isBooked'];
    retailerId = json['retailer_id'];
    shopName = json['shop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['customer_id'] = this.customerId;
    data['isBooked'] = this.isBooked;
    data['retailer_id'] = this.retailerId;
    data['shop_name'] = this.shopName;
    return data;
  }
}
