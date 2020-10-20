class Holidayresponse {
  Holidayresult holidayresult;

  Holidayresponse({this.holidayresult});

  Holidayresponse.fromJson(Map<String, dynamic> json) {
    holidayresult = json['holidayresult'] != null
        ? new Holidayresult.fromJson(json['holidayresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holidayresult != null) {
      data['holidayresult'] = this.holidayresult.toJson();
    }
    return data;
  }
}

class Holidayresult {
  int isError;
  String message;

  Holidayresult({this.isError, this.message});

  Holidayresult.fromJson(Map<String, dynamic> json) {
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
