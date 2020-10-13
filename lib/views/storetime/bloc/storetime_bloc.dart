import 'package:Retailer/views/storetime/bloc/storetime_event.dart';
import 'package:Retailer/views/storetime/bloc/storetime_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/repositories/api_repository.dart';

class StoreTimeBloc extends Bloc<StoreTimeEvent, StoreTimeState> {
  final APIRepository apireporsitory;

  StoreTimeBloc({@required this.apireporsitory}) : super(StoreTimeInitial());

  // @override
  // BookTicketState get initialState => BookTicketInitial();

  @override
  Stream<StoreTimeState> mapEventToState(StoreTimeEvent event) async* {
    print("event --- $event");
    if (event is RetailerUpdateEvent) {
      yield StoreTimeInProgress();

      try {
        final result = await apireporsitory.submitShopTimeSlot(
            requestMap: event.requestMap);

        yield RetailerUpdateSuccess(result);
      } catch (error) {
        yield StoreTimeFailure(error: error.toString());
      }
    } else if (event is SelectTimeSlot) {
      yield ShopTimeSlotSuccess(event.startTime, event.endTime);
    }
  }
}
