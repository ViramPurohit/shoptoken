import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MyBookingEvent extends Equatable {
  const MyBookingEvent();
}

class MyBookingEventListEvent extends MyBookingEvent {
  final Map<String, dynamic> requestMap;

  MyBookingEventListEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "MyBookingEventListEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class AddToFavButtonEvent extends MyBookingEvent {
  final Map<String, dynamic> requestMap;

  AddToFavButtonEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "MyBookingEventListEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
