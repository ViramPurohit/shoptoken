import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_repository.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket.dart';

class BookTicketBloc extends Bloc<BookTicketEvent, BookTicketState> {
  final APIRepository apireporsitory;

  BookTicketBloc({@required this.apireporsitory}) : super(BookTicketInitial());

  // @override
  // BookTicketState get initialState => BookTicketInitial();

  @override
  Stream<BookTicketState> mapEventToState(BookTicketEvent event) async* {
    print("event --- $event");
    if (event is SelectDateEvent) {
      yield SelectDateSuccess(event.bookDate);
    }

    if (event is SelectDayButtonEvent) {
      yield SlotListInProgress();

      try {
        final result =
            await apireporsitory.geSlotList(requestMap: event.requestMap);

        yield SlotListSuccess(result);
      } catch (error) {
        yield SlotListFailure(error: error.toString());
      }
    }
    if (event is BookButtonEvent) {
      yield BookTicketInProgress();
      try {
        final result =
            await apireporsitory.bookSlot(requestMap: event.requestMap);
        print("response --- $result");
        yield BookTicketSuccess(result);
      } catch (error) {
        yield BookTicketFailure(error: error.toString());
      }
    }
  }
}
