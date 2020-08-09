import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String name;

  LoginButtonPressed({@required this.name});

  @override
  String toString() => "On Login click { User name : $name }";

  @override
  List<Object> get props => [name];
}
