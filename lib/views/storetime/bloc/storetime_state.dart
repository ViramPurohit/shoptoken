import 'package:Retailer/models/categorysubmit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Retailer/models/getallslots.dart';

abstract class StoreTimeState extends Equatable {
  const StoreTimeState();
  @override
  List<Object> get props => [];
}

class StoreTimeInitial extends StoreTimeState {}

class StoreTimeInProgress extends StoreTimeState {}

class StoreTimeFailure extends StoreTimeState {
  final String error;

  const StoreTimeFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class RetailerUpdateSuccess extends StoreTimeState {
  final CategorySubmitResponse result;

  RetailerUpdateSuccess(this.result);

  @override
  String toString() => 'BookTicket StateSuccess ';
}

class ShopTimeSlotSuccess extends StoreTimeState {
  final String startTime, endTime;

  ShopTimeSlotSuccess(this.startTime, this.endTime);

  @override
  String toString() => 'ShopTimeSlotSuccess StateSuccess ';
}
