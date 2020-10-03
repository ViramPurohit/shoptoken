class BookSlotsResponse {
  Bookingresult bookingresult;

  BookSlotsResponse({this.bookingresult});

  BookSlotsResponse.fromJson(Map<String, dynamic> json) {
    bookingresult = json['bookingresult'] != null
        ? new Bookingresult.fromJson(json['bookingresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingresult != null) {
      data['bookingresult'] = this.bookingresult.toJson();
    }
    return data;
  }
}

class Bookingresult {
  int confirmCode;
  int isError;
  String message;
  int ticketNumber;

  Bookingresult(
      {this.confirmCode, this.isError, this.message, this.ticketNumber});

  Bookingresult.fromJson(Map<String, dynamic> json) {
    confirmCode = json['confirm_code'];
    isError = json['isError'];
    message = json['message'];
    ticketNumber = json['ticket_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm_code'] = this.confirmCode;
    data['isError'] = this.isError;
    data['message'] = this.message;
    data['ticket_number'] = this.ticketNumber;
    return data;
  }
}
