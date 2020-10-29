class Verifycustomerresponse {
  Verifycustomerresult verifycustomerresult;

  Verifycustomerresponse({this.verifycustomerresult});

  Verifycustomerresponse.fromJson(Map<String, dynamic> json) {
    verifycustomerresult = json['verifycustomerresult'] != null
        ? new Verifycustomerresult.fromJson(json['verifycustomerresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verifycustomerresult != null) {
      data['verifycustomerresult'] = this.verifycustomerresult.toJson();
    }
    return data;
  }
}

class Verifycustomerresult {
  int customerId;
  int isError;
  String message;

  Verifycustomerresult({this.customerId, this.isError, this.message});

  Verifycustomerresult.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    isError = json['isError'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['isError'] = this.isError;
    data['message'] = this.message;
    return data;
  }
}
