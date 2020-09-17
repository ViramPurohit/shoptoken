class CategoryResponse {
  String englishName;
  String hindiName;
  int id;

  CategoryResponse({this.englishName, this.hindiName, this.id});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    hindiName = json['hindi_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english_name'] = this.englishName;
    data['hindi_name'] = this.hindiName;
    data['id'] = this.id;
    return data;
  }
}
