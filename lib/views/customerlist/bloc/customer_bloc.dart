import 'package:Retailer/views/customerlist/bloc/customer_event.dart';
import 'package:Retailer/views/customerlist/bloc/customer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/repositories/api_repository.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final APIRepository apireporsitory;

  CustomerBloc({@required this.apireporsitory}) : super(CustomerInitial());

  // @override
  // BookTicketState get initialState => BookTicketInitial();

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {
    print("event --- $event");
    if (event is CustomerListEvent) {
      yield CustomerProgress();
      try {
        final result = await apireporsitory.geSlotList();
        print("response --- $result");
        yield CustomerSuccess(result);
      } catch (error) {
        yield CustomerFailure(error: error.toString());
      }
    }
    if (event is EnterCodeButtonEvent) {
      yield CustomerProgress();
      try {
        final result = await apireporsitory.geSlotList();
        print("response --- $result");
        yield CodeVerificationSuccess(result);
      } catch (error) {
        yield CustomerFailure(error: error.toString());
      }
    }
  }
}
