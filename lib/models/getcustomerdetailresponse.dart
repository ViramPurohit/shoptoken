class GetCustomerdetailresponse {
  Getcustomerdetailresult getcustomerdetailresult;

  GetCustomerdetailresponse({this.getcustomerdetailresult});

  GetCustomerdetailresponse.fromJson(Map<String, dynamic> json) {
    getcustomerdetailresult = json['getcustomerdetailresult'] != null
        ? new Getcustomerdetailresult.fromJson(json['getcustomerdetailresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getcustomerdetailresult != null) {
      data['getcustomerdetailresult'] = this.getcustomerdetailresult.toJson();
    }
    return data;
  }
}

class Getcustomerdetailresult {
  List<CustomerData> data;
  int isError;
  String message;

  Getcustomerdetailresult({this.data, this.isError, this.message});

  Getcustomerdetailresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CustomerData>();
      json['data'].forEach((v) {
        data.add(new CustomerData.fromJson(v));
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

class CustomerData {
  String address;
  String fullName;
  String mobileNo;

  CustomerData({this.address, this.fullName, this.mobileNo});

  CustomerData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['full_name'] = this.fullName;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}
