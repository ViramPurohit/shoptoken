import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookTicketEvent extends Equatable {
  const BookTicketEvent();
}

class BookButtonEvent extends BookTicketEvent {
  final Map<String, dynamic> requestMap;

  BookButtonEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "BookButtonEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class SelectDayButtonEvent extends BookTicketEvent {
  final Map<String, dynamic> requestMap;

  SelectDayButtonEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SelectDayButtonEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class SelectDateEvent extends BookTicketEvent {
  final String bookDate;

  SelectDateEvent({@required this.bookDate});

  // get name => null;

  @override
  String toString() => "SelectDayButtonEvent { User name : $bookDate}";

  @override
  List<Object> get props => [bookDate];
}
