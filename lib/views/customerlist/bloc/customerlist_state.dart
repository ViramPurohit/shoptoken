import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/models/getallslots.dart';

abstract class CustomerListState extends Equatable {
  const CustomerListState();
  @override
  List<Object> get props => [];
}

class SlotListInitial extends CustomerListState {}

class SlotListInProgress extends CustomerListState {}

class SlotListFailure extends CustomerListState {
  final String error;

  const SlotListFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class SlotListSuccess extends CustomerListState {
  final GetAllSlotsResponse result;

  SlotListSuccess(this.result);

  @override
  String toString() => 'BookTicket StateSuccess ';
}

class BookTicketInitial extends CustomerListState {}

class BookTicketInProgress extends CustomerListState {}

class BookTicketFailure extends CustomerListState {
  final String error;

  const BookTicketFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class BookTicketSuccess extends CustomerListState {
  final BookSlotsResponse result;

  BookTicketSuccess(this.result);

  @override
  String toString() => 'BookTicket StateSuccess ';
}
