import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_repository.dart';

import 'mybookinglist.dart';

class MyBookTicketBloc extends Bloc<MyBookingEvent, MyBookingListState> {
  final APIRepository apireporsitory;

  MyBookTicketBloc({@required this.apireporsitory})
      : super(MyBookingListInitial());

  // @override
  // BookTicketState get initialState => BookTicketInitial();

  @override
  Stream<MyBookingListState> mapEventToState(MyBookingEvent event) async* {
    print("event --- $event");
    if (event is MyBookingEventListEvent) {
      yield MyBookingListInProgress();
      try {
        final result = await apireporsitory.getallcustomerbooking(
            requestMap: event.requestMap);
        print("response --- $result");
        yield MyBookingListSuccess(result);
      } catch (error) {
        yield MyBookingListFailure(error: error.toString());
      }
    }
    if (event is AddToFavButtonEvent) {
      yield AddToFavInProgress();
      try {
        final result =
            await apireporsitory.addtofavorite(requestMap: event.requestMap);
        print("response --- $result");
        yield AddToFavButtonSuccess(result);
      } catch (error) {
        yield MyBookingListFailure(error: error.toString());
      }
    }
  }
}
