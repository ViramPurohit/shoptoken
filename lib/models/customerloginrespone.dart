class Customerloginresponse {
  Customerloginresult customerloginresult;

  Customerloginresponse({this.customerloginresult});

  Customerloginresponse.fromJson(Map<String, dynamic> json) {
    customerloginresult = json['customerloginresult'] != null
        ? new Customerloginresult.fromJson(json['customerloginresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerloginresult != null) {
      data['customerloginresult'] = this.customerloginresult.toJson();
    }
    return data;
  }
}

class Customerloginresult {
  String fullName;
  int id;
  int isError;
  String message;
  String mobileNo;

  Customerloginresult(
      {this.fullName, this.id, this.isError, this.message, this.mobileNo});

  Customerloginresult.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
    isError = json['isError'];
    message = json['message'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['isError'] = this.isError;
    data['message'] = this.message;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}
