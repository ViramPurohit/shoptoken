import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:shoptoken/models/customerloginrespone.dart';
import 'package:shoptoken/models/customerregisterresponse.dart';
import 'package:shoptoken/models/resetcustomerrespone.dart';
import 'package:shoptoken/models/verifycustomerrespone.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {
  @override
  String toString() => 'LoginInProgress';
}

class SignupInProgress extends LoginState {
  @override
  String toString() => 'SignupInProgress';
}

class UploadShopCertificateInProgress extends LoginState {
  @override
  String toString() => 'UploadShopCertificateInProgress';
}

class VerifyRetailerInProgress extends LoginState {
  @override
  String toString() => 'VerifyRetailerInProgress';
}

class ConfirmPasswordInProgress extends LoginState {
  @override
  String toString() => 'ConfirmPasswordInProgress';
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginErrorMsg extends LoginState {
  final String error;

  const LoginErrorMsg({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginSuccess extends LoginState {
  final Customerloginresponse result;

  LoginSuccess(this.result);

  @override
  String toString() =>
      'Login StateSuccess { Id: ${result.customerloginresult.id} }';
}

class SignupSuccess extends LoginState {
  final CustomerRegisterResponse result;

  SignupSuccess(this.result);

  @override
  String toString() =>
      'Login StateSuccess { Id: ${result.customerregisterResult.id} }';
}

class VerifyMobileSuccess extends LoginState {
  final Verifycustomerresponse result;

  VerifyMobileSuccess(this.result);

  @override
  String toString() =>
      'VerifyMobileSuccess StateSuccess { Id: ${result.verifycustomerresult.message} }';
}

class ResetPasswordSuccess extends LoginState {
  final Resetcustomerresponse result;

  ResetPasswordSuccess(this.result);

  @override
  String toString() =>
      'ResetPasswordSuccess StateSuccess { Id: ${result.resetcustomerresult.message} }';
}
