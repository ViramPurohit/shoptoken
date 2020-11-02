import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/models/getfavoriteresponse.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteInProgress extends FavouriteState {}

class FavouriteFailure extends FavouriteState {
  final String error;

  const FavouriteFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BookTicket Failure { error: $error }';
}

class FavouriteSuccess extends FavouriteState {
  final Getfavoriteresponse result;

  FavouriteSuccess(this.result);

  @override
  String toString() => 'MyBookingListSuccess StateSuccess ';
}
