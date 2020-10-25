class Resetretailerresponse {
  Resetretailerresult resetretailerresult;

  Resetretailerresponse({this.resetretailerresult});

  Resetretailerresponse.fromJson(Map<String, dynamic> json) {
    resetretailerresult = json['resetretailerresult'] != null
        ? new Resetretailerresult.fromJson(json['resetretailerresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resetretailerresult != null) {
      data['resetretailerresult'] = this.resetretailerresult.toJson();
    }
    return data;
  }
}

class Resetretailerresult {
  int isError;
  String message;

  Resetretailerresult({this.isError, this.message});

  Resetretailerresult.fromJson(Map<String, dynamic> json) {
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
