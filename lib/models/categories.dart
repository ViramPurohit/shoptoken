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
  int id;
  String url;

  CategoryData({this.englishName, this.hindiName, this.id, this.url});

  CategoryData.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    hindiName = json['hindi_name'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english_name'] = this.englishName;
    data['hindi_name'] = this.hindiName;
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
