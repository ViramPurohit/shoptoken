import 'package:Retailer/models/categorysubmit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Retailer/models/categories.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryInProgress extends CategoryState {}

class CategoryFailure extends CategoryState {
  final String error;

  const CategoryFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Category Failure { error: $error }';
}

class CategorySuccess extends CategoryState {
  final CategoryResponse result;

  CategorySuccess(this.result);

  @override
  String toString() => 'Category StateSuccess ';
}

class CategorySelectSuccess extends CategoryState {
  final List<CategoryData> result;

  CategorySelectSuccess(this.result);

  @override
  String toString() => 'Category Select StateSuccess ';
}

class CategorySubmitSuccess extends CategoryState {
  final CategorySubmitResponse result;

  CategorySubmitSuccess(this.result);

  @override
  String toString() => 'Category Select StateSuccess ';
}