class RegisterUser {
  String address;
  String fullName;
  int id;
  int isError;
  String message;
  String mobileNo;

  RegisterUser(
      {this.address,
      this.fullName,
      this.id,
      this.isError,
      this.message,
      this.mobileNo});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    fullName = json['full_name'];
    id = json['id'];
    isError = json['isError'];
    message = json['message'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['isError'] = this.isError;
    data['message'] = this.message;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}
