import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/getallslots.dart';

abstract class BookTicketState extends Equatable {
  const BookTicketState();
  @override
  List<Object> get props => [];
}

class SlotListInitial extends BookTicketState {}

class SlotListInProgress extends BookTicketState {}

class SlotListFailure extends BookTicketState {
  final String error;

  const SlotListFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class SlotListSuccess extends BookTicketState {
  final GetAllSlotsResponse result;

  SlotListSuccess(this.result);

  @override
  String toString() => 'BookTicket StateSuccess ';
}

class BookTicketInitial extends BookTicketState {}

class BookTicketInProgress extends BookTicketState {}

class BookTicketFailure extends BookTicketState {
  final String error;

  const BookTicketFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class BookTicketSuccess extends BookTicketState {
  final BookSlotsResponse result;

  BookTicketSuccess(this.result);

  @override
  String toString() => 'BookTicket StateSuccess ';
}
