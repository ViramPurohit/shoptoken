import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
}

class CustomerListEvent extends CustomerEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class EnterCodeButtonEvent extends CustomerEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Booked Ticket for Users";
}
