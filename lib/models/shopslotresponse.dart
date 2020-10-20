class ShopuserslotResponse {
  ShopuserslotResult shopuserslotResult;

  ShopuserslotResponse({this.shopuserslotResult});

  ShopuserslotResponse.fromJson(Map<String, dynamic> json) {
    shopuserslotResult = json['shopuserslotResult'] != null
        ? new ShopuserslotResult.fromJson(json['shopuserslotResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopuserslotResult != null) {
      data['shopuserslotResult'] = this.shopuserslotResult.toJson();
    }
    return data;
  }
}

class ShopuserslotResult {
  int isError;
  String message;

  ShopuserslotResult({this.isError, this.message});

  ShopuserslotResult.fromJson(Map<String, dynamic> json) {
    isError = json['isError'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isError'] = this.isError;
    data['message'] = this.message;
    return data;
  }
}
