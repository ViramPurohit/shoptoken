class Customerbookingresponse {
  Customerbookingresult customerbookingresult;

  Customerbookingresponse({this.customerbookingresult});

  Customerbookingresponse.fromJson(Map<String, dynamic> json) {
    customerbookingresult = json['customerbookingresult'] != null
        ? new Customerbookingresult.fromJson(json['customerbookingresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerbookingresult != null) {
      data['customerbookingresult'] = this.customerbookingresult.toJson();
    }
    return data;
  }
}

class Customerbookingresult {
  List<CustomerbookingData> data;
  int isError;
  String message;

  Customerbookingresult({this.data, this.isError, this.message});

  Customerbookingresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CustomerbookingData>();
      json['data'].forEach((v) {
        data.add(new CustomerbookingData.fromJson(v));
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

class CustomerbookingData {
  String bookEndTime;
  int bookId;
  String bookStartTime;
  int confirmCode;
  String fullName;
  String mobileNo;
  int ticketNumber;
  int retailerId;

  CustomerbookingData(
      {this.bookEndTime,
      this.bookId,
      this.bookStartTime,
      this.confirmCode,
      this.fullName,
      this.mobileNo,
      this.ticketNumber,
      this.retailerId});

  CustomerbookingData.fromJson(Map<String, dynamic> json) {
    bookEndTime = json['book_end_time'];
    bookId = json['book_id'];
    bookStartTime = json['book_start_time'];
    confirmCode = json['confirm_code'];
    fullName = json['shop_name'];
    mobileNo = json['shop_mobile_no'];
    ticketNumber = json['ticket_number'];
    retailerId = json['retailer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_end_time'] = this.bookEndTime;
    data['book_id'] = this.bookId;
    data['book_start_time'] = this.bookStartTime;
    data['confirm_code'] = this.confirmCode;
    data['full_name'] = this.fullName;
    data['mobile_no'] = this.mobileNo;
    data['ticket_number'] = this.ticketNumber;
    data['ticket_number'] = this.retailerId;
    return data;
  }
}
