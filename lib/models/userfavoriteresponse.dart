class Userfavoriteresponse {
  Userfavoriteresult userfavoriteresult;

  Userfavoriteresponse({this.userfavoriteresult});

  Userfavoriteresponse.fromJson(Map<String, dynamic> json) {
    userfavoriteresult = json['userfavoriteresult'] != null
        ? new Userfavoriteresult.fromJson(json['userfavoriteresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userfavoriteresult != null) {
      data['userfavoriteresult'] = this.userfavoriteresult.toJson();
    }
    return data;
  }
}

class Userfavoriteresult {
  int isError;
  String message;

  Userfavoriteresult({this.isError, this.message});

  Userfavoriteresult.fromJson(Map<String, dynamic> json) {
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
