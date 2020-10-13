import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StoreTimeEvent extends Equatable {
  const StoreTimeEvent();
}

class SlotListEvent extends StoreTimeEvent {
  final Map<String, dynamic> requestMap;

  SlotListEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "BookButtonEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
