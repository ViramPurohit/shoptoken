import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_repository.dart';

import 'favourite.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final APIRepository apireporsitory;

  FavouriteBloc({@required this.apireporsitory}) : super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event) async* {
    print("event --- $event");
    if (event is MyFavouriteListEvent) {
      yield FavouriteInProgress();
      try {
        final result = await apireporsitory.getfavoriteretailer(
            requestMap: event.requestMap);
        print("response --- $result");
        yield FavouriteSuccess(result);
      } catch (error) {
        yield FavouriteFailure(error: error.toString());
      }
    }
  }
}
