class Resetcustomerresponse {
  Resetcustomerresult resetcustomerresult;

  Resetcustomerresponse({this.resetcustomerresult});

  Resetcustomerresponse.fromJson(Map<String, dynamic> json) {
    resetcustomerresult = json['resetcustomerresult'] != null
        ? new Resetcustomerresult.fromJson(json['resetcustomerresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resetcustomerresult != null) {
      data['resetcustomerresult'] = this.resetcustomerresult.toJson();
    }
    return data;
  }
}

class Resetcustomerresult {
  int isError;
  String message;

  Resetcustomerresult({this.isError, this.message});

  Resetcustomerresult.fromJson(Map<String, dynamic> json) {
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
