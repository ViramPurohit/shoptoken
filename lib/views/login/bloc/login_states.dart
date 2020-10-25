import 'package:Retailer/models/resetretailerresponse.dart';
import 'package:Retailer/models/retailerloginresponse.dart';
import 'package:Retailer/models/verifyretailerresponse.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:Retailer/models/registeuser.dart';
import 'package:Retailer/service/uploadphoto.dart';

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
  final Retailerloginrespone result;

  LoginSuccess(this.result);

  @override
  String toString() =>
      'Login StateSuccess { Id: ${result.retailerloginresult.id} }';
}

class SignupSuccess extends LoginState {
  final RetailerregisterResponse result;

  SignupSuccess(this.result);

  @override
  String toString() =>
      'Login StateSuccess { Id: ${result.retailerregisterResult.id} }';
}

class UploadCertificateSuccess extends LoginState {
  final ShopCertificateResponse result;

  UploadCertificateSuccess(this.result);

  @override
  String toString() =>
      'UploadCertificateSuccess StateSuccess { Id: ${result.uploadshopCertificateResult.message} }';
}

class VerifyMobileSuccess extends LoginState {
  final Verifyretailerresponse result;

  VerifyMobileSuccess(this.result);

  @override
  String toString() =>
      'VerifyMobileSuccess StateSuccess { Id: ${result.verifyretailerresult.message} }';
}

class ResetPasswordSuccess extends LoginState {
  final Resetretailerresponse result;

  ResetPasswordSuccess(this.result);

  @override
  String toString() =>
      'ResetPasswordSuccess StateSuccess { Id: ${result.resetretailerresult.message} }';
}
