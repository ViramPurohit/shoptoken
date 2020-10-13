import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StoreTimeEvent extends Equatable {
  const StoreTimeEvent();
}

class RetailerUpdateEvent extends StoreTimeEvent {
  final Map<String, dynamic> requestMap;

  RetailerUpdateEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "BookButtonEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class SelectTimeSlot extends StoreTimeEvent {
  final String startTime, endTime;

  SelectTimeSlot({@required this.startTime, @required this.endTime});

  // get name => null;

  @override
  String toString() => "SelectDayButtonEvent { User name : $startTime}";

  @override
  List<Object> get props => [startTime, endTime];
}
