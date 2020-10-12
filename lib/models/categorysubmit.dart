class CategorySubmitResponse {
  Categoryresult categoryresult;

  CategorySubmitResponse({this.categoryresult});

  CategorySubmitResponse.fromJson(Map<String, dynamic> json) {
    categoryresult = json['categoryresult'] != null
        ? new Categoryresult.fromJson(json['categoryresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryresult != null) {
      data['categoryresult'] = this.categoryresult.toJson();
    }
    return data;
  }
}

class Categoryresult {
  int isError;
  String message;

  Categoryresult({this.isError, this.message});

  Categoryresult.fromJson(Map<String, dynamic> json) {
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
