class ShopCertificateResponse {
  UploadshopCertificateResult uploadshopCertificateResult;

  ShopCertificateResponse({this.uploadshopCertificateResult});

  ShopCertificateResponse.fromJson(Map<String, dynamic> json) {
    uploadshopCertificateResult = json['uploadshopCertificateResult'] != null
        ? new UploadshopCertificateResult.fromJson(
            json['uploadshopCertificateResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uploadshopCertificateResult != null) {
      data['uploadshopCertificateResult'] =
          this.uploadshopCertificateResult.toJson();
    }
    return data;
  }
}

class UploadshopCertificateResult {
  int isError;
  String message;

  UploadshopCertificateResult({this.isError, this.message});

  UploadshopCertificateResult.fromJson(Map<String, dynamic> json) {
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
