import 'package:equatable/equatable.dart';

abstract class NearestStoreEvent extends Equatable {
  const NearestStoreEvent();
}

class FetchNearestStoreEventList extends NearestStoreEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Collect category List";
}
