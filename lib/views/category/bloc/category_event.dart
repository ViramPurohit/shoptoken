import 'package:Retailer/models/categories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class FetchCategoryList extends CategoryEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class CategoryItemSelect extends CategoryEvent {
  final List<CategoryData> selectedList;

  CategoryItemSelect({@required this.selectedList});

  // get name => null;

  @override
  String toString() => "CategoryItemSelect { Request Data: list}";

  @override
  List<Object> get props => [selectedList];
}

class SubmitCategoryEvent extends CategoryEvent {
  final Map<String, dynamic> requestMap;

  SubmitCategoryEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SubmitCategoryEvent { Request Data: $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
