class RetailerbookingResponse {
  Retailerbookingresult retailerbookingresult;

  RetailerbookingResponse({this.retailerbookingresult});

  RetailerbookingResponse.fromJson(Map<String, dynamic> json) {
    retailerbookingresult = json['retailerbookingresult'] != null
        ? new Retailerbookingresult.fromJson(json['retailerbookingresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailerbookingresult != null) {
      data['retailerbookingresult'] = this.retailerbookingresult.toJson();
    }
    return data;
  }
}

class Retailerbookingresult {
  List<RetailerbookinData> data;
  int isError;
  String message;

  Retailerbookingresult({this.data, this.isError, this.message});

  Retailerbookingresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RetailerbookinData>();
      json['data'].forEach((v) {
        data.add(new RetailerbookinData.fromJson(v));
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

class RetailerbookinData {
  String bookEndTime;
  String bookStartTime;
  String fullName;
  String mobileNo;
  int ticketNumber;
  int bookId;

  RetailerbookinData(
      {this.bookEndTime,
      this.bookStartTime,
      this.fullName,
      this.mobileNo,
      this.ticketNumber,
      this.bookId});

  RetailerbookinData.fromJson(Map<String, dynamic> json) {
    bookEndTime = json['book_end_time'];
    bookStartTime = json['book_start_time'];
    fullName = json['full_name'];
    mobileNo = json['mobile_no'];
    ticketNumber = json['ticket_number'];
    bookId = json['book_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_end_time'] = this.bookEndTime;
    data['book_start_time'] = this.bookStartTime;
    data['full_name'] = this.fullName;
    data['mobile_no'] = this.mobileNo;
    data['ticket_number'] = this.ticketNumber;
    data['book_id'] = this.bookId;
    return data;
  }
}
