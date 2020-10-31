class GetAllSlotsResponse {
  SlotListresult nearshopresult;

  GetAllSlotsResponse({this.nearshopresult});

  GetAllSlotsResponse.fromJson(Map<String, dynamic> json) {
    nearshopresult = json['slotlistresult'] != null
        ? new SlotListresult.fromJson(json['slotlistresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearshopresult != null) {
      data['slotlistresult'] = this.nearshopresult.toJson();
    }
    return data;
  }
}

class SlotListresult {
  List<SlotData> data;
  int isError;
  String message;

  SlotListresult({this.data, this.isError, this.message});

  SlotListresult.fromJson(Map<String, dynamic> json) {
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
  bool isSelect = false;

  SlotData({this.endTime, this.startTime, this.isSelect});

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
