import 'package:Retailer/models/retailerdetailresult.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserprofileState extends Equatable {
  const UserprofileState();
  @override
  List<Object> get props => [];
}

class UserprofileInitial extends UserprofileState {}

class UserprofileProgress extends UserprofileState {}

class UserprofileFailure extends UserprofileState {
  final String error;

  const UserprofileFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SettingList Failure { error: $error }';
}

class RetailerdetailSuccess extends UserprofileState {
  final RetailerdetailResponse result;

  RetailerdetailSuccess(this.result);

  @override
  String toString() => 'SettingSuccess StateSuccess ';
}