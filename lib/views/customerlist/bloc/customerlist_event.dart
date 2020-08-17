import 'package:equatable/equatable.dart';

abstract class CustomerListEvent extends Equatable {
  const CustomerListEvent();
}

class BookedCustomerListEvent extends CustomerListEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class EnterCodeButtonEvent extends CustomerListEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Booked Ticket for Users";
}
