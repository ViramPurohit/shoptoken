import 'package:equatable/equatable.dart';

abstract class BookTicketEvent extends Equatable {
  const BookTicketEvent();
}

class SelectDayButtonEvent extends BookTicketEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class BookButtonEvent extends BookTicketEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Booked Ticket for Users";
}
