import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class FetchCategoryList extends CategoryEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}
