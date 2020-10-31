import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/models/getcustomerdetailresponse.dart';
import 'package:shoptoken/models/userfavoriteresponse.dart';

abstract class MyBookingListState extends Equatable {
  const MyBookingListState();
  @override
  List<Object> get props => [];
}

class MyBookingListInitial extends MyBookingListState {}

class MyBookingListInProgress extends MyBookingListState {}

class AddToFavInProgress extends MyBookingListState {}

class MyBookingListFailure extends MyBookingListState {
  final String error;

  const MyBookingListFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class MyBookingListSuccess extends MyBookingListState {
  final Customerbookingresponse result;

  MyBookingListSuccess(this.result);

  @override
  String toString() => 'MyBookingListSuccess StateSuccess ';
}

class AddToFavButtonSuccess extends MyBookingListState {
  final Userfavoriteresponse result;

  AddToFavButtonSuccess(this.result);

  @override
  String toString() => 'AddToFavButtonSuccess StateSuccess ';
}
