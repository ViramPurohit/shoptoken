import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/models/registeuser.dart';
import 'package:shoptoken/service/uploadphoto.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

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
  final RegisterUser result;

  LoginSuccess(this.result);

  @override
  String toString() => 'Login StateSuccess { Id: ${result.id} }';
}
