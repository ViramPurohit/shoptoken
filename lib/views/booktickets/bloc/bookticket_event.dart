import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookTicketEvent extends Equatable {
  const BookTicketEvent();
}

class BookButtonEvent extends BookTicketEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}

class SelectDayButtonEvent extends BookTicketEvent {
  final Map<String, dynamic> requestMap;

  SelectDayButtonEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "On Login click { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
