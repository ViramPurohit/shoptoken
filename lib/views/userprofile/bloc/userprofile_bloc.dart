import 'package:Retailer/views/userprofile/bloc/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/repositories/api_repository.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  final APIRepository apireporsitory;

  UserprofileBloc({@required this.apireporsitory})
      : super(UserprofileInitial());

  @override
  Stream<UserprofileState> mapEventToState(UserprofileEvent event) async* {
    print("event --- $event");
    if (event is UserDetailsEvent) {
      yield UserprofileProgress();
      try {
        final result = await apireporsitory.getretailerdetail(
            requestMap: event.requestMap);
        print("response --- $result");
        yield RetailerdetailSuccess(result);
      } catch (error) {
        yield UserprofileFailure(error: error.toString());
      }
    }
  }
}
