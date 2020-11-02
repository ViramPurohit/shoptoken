import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/categories.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class FetchCategoryList extends CategoryEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class CategorySelectList extends CategoryEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class CategorySelectEvent extends CategoryEvent {
  final String categoryIds;

  CategorySelectEvent({@required this.categoryIds});

  // get name => null;

  @override
  String toString() => "CategorySelectEvent { User name : $categoryIds}";

  @override
  List<Object> get props => [categoryIds];
}
