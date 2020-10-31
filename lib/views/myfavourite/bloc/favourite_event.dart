import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class MyFavouriteListEvent extends FavouriteEvent {
  final Map<String, dynamic> requestMap;

  MyFavouriteListEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "MyBookingEventListEvent { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
