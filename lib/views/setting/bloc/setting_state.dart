import 'package:Retailer/models/holidayresponse.dart';
import 'package:Retailer/models/retailerallbookings.dart';
import 'package:Retailer/models/shopslotresponse.dart';
import 'package:Retailer/models/verifycoderesult.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SettingState extends Equatable {
  const SettingState();
  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingProgress extends SettingState {}

class SettingFailure extends SettingState {
  final String error;

  const SettingFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SettingList Failure { error: $error }';
}

class ChangeSlotValueSuccess extends SettingState {
  final ShopuserslotResponse result;

  ChangeSlotValueSuccess(this.result);

  @override
  String toString() => 'SettingSuccess StateSuccess ';
}

class EnableHolidaySuccess extends SettingState {
  final Holidayresponse result;

  EnableHolidaySuccess(this.result);

  @override
  String toString() => 'CodeVerificationSuccess StateSuccess ';
}
