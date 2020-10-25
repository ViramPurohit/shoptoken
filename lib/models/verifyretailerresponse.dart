class Verifyretailerresponse {
  Verifyretailerresult verifyretailerresult;

  Verifyretailerresponse({this.verifyretailerresult});

  Verifyretailerresponse.fromJson(Map<String, dynamic> json) {
    verifyretailerresult = json['verifyretailerresult'] != null
        ? new Verifyretailerresult.fromJson(json['verifyretailerresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verifyretailerresult != null) {
      data['verifyretailerresult'] = this.verifyretailerresult.toJson();
    }
    return data;
  }
}

class Verifyretailerresult {
  int isError;
  String message;
  int retailerId;

  Verifyretailerresult({this.isError, this.message, this.retailerId});

  Verifyretailerresult.fromJson(Map<String, dynamic> json) {
    isError = json['isError'];
    message = json['message'];
    retailerId = json['retailer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isError'] = this.isError;
    data['message'] = this.message;
    data['retailer_id'] = this.retailerId;
    return data;
  }
}
