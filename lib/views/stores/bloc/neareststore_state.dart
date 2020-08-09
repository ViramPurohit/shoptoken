import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/categories.dart';

abstract class NearestStoreState extends Equatable {
  const NearestStoreState();
  @override
  List<Object> get props => [];
}

class NearestStoreInitial extends NearestStoreState {}

class NearestStoreInProgress extends NearestStoreState {}

class NearestStoreFailure extends NearestStoreState {
  final String error;

  const NearestStoreFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'NearestStore Failure { error: $error }';
}

class NearestStoreSuccess extends NearestStoreState {
  final CategoryResponse result;

  NearestStoreSuccess(this.result);

  @override
  String toString() => 'NearestStore StateSuccess ';
}
