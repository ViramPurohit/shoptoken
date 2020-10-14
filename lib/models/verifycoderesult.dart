class VerifyCodeResponse {
  VerifyCoderesult verifyCoderesult;

  VerifyCodeResponse({this.verifyCoderesult});

  VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    verifyCoderesult = json['verifyCoderesult'] != null
        ? new VerifyCoderesult.fromJson(json['verifyCoderesult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verifyCoderesult != null) {
      data['verifyCoderesult'] = this.verifyCoderesult.toJson();
    }
    return data;
  }
}

class VerifyCoderesult {
  int isError;
  String message;

  VerifyCoderesult({this.isError, this.message});

  VerifyCoderesult.fromJson(Map<String, dynamic> json) {
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
