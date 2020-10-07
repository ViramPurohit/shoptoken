import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Retailer/models/bookslots.dart';
import 'package:Retailer/models/getallslots.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();
  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerProgress extends CustomerState {}

class CustomerFailure extends CustomerState {
  final String error;

  const CustomerFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CustomerList Failure { error: $error }';
}

class CustomerSuccess extends CustomerState {
  final GetAllSlotsResponse result;

  CustomerSuccess(this.result);

  @override
  String toString() => 'CustomerSuccess StateSuccess ';
}

class CodeVerificationSuccess extends CustomerState {
  final GetAllSlotsResponse result;

  CodeVerificationSuccess(this.result);

  @override
  String toString() => 'CodeVerificationSuccess StateSuccess ';
}
