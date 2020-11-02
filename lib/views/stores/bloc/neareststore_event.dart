import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NearestStoreEvent extends Equatable {
  const NearestStoreEvent();
}

class FetchNearestStoreEventList extends NearestStoreEvent {
  final Map<String, dynamic> requestMap;

  FetchNearestStoreEventList({@required this.requestMap});

  @override
  List<Object> get props => [requestMap];

  @override
  String toString() => "Collect category List $requestMap";
}
