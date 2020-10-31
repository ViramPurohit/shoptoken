class CategoryResponse {
  Categorylistresult categorylistresult;

  CategoryResponse({this.categorylistresult});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    categorylistresult = json['categorylistresult'] != null
        ? new Categorylistresult.fromJson(json['categorylistresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categorylistresult != null) {
      data['categorylistresult'] = this.categorylistresult.toJson();
    }
    return data;
  }
}

class Categorylistresult {
  List<CategoryData> data;
  int isError;
  String message;

  Categorylistresult({this.data, this.isError, this.message});

  Categorylistresult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CategoryData>();
      json['data'].forEach((v) {
        data.add(new CategoryData.fromJson(v));
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

class CategoryData {
  String englishName;
  String hindiName;
  String categoryurl;
  int id;

  CategoryData({this.englishName, this.hindiName, this.id, this.categoryurl});

  CategoryData.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    hindiName = json['hindi_name'];
    categoryurl = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english_name'] = this.englishName;
    data['hindi_name'] = this.hindiName;
    data['url'] = this.categoryurl;
    data['id'] = this.id;
    return data;
  }
}
