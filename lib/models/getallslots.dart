class GetAllSlotsResponse {
  Nearshopresult nearshopresult;

  GetAllSlotsResponse({this.nearshopresult});

  GetAllSlotsResponse.fromJson(Map<String, dynamic> json) {
    nearshopresult = json['nearshopresult'] != null
        ? new Nearshopresult.fromJson(json['nearshopresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearshopresult != null) {
      data['nearshopresult'] = this.nearshopresult.toJson();
    }
    return data;
  }
}

class Nearshopresult {
  List<SlotData> data;
  int isError;
  String message;

  Nearshopresult({this.data, this.isError, this.message});

  Nearshopresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SlotData>();
      json['data'].forEach((v) {
        data.add(new SlotData.fromJson(v));
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

class SlotData {
  String endTime;
  String startTime;

  SlotData({this.endTime, this.startTime});

  SlotData.fromJson(Map<String, dynamic> json) {
    endTime = json['EndTime'];
    startTime = json['StartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EndTime'] = this.endTime;
    data['StartTime'] = this.startTime;
    return data;
  }
}
