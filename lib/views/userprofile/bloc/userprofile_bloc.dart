import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoptoken/repositories/api_repository.dart';

import 'userprofile_event.dart';
import 'userprofile_state.dart';

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
        final result = await apireporsitory.getcustomerdetail(
            requestMap: event.requestMap);
        print("response --- $result");
        yield CustomerdetailSuccess(result);
      } catch (error) {
        yield UserprofileFailure(error: error.toString());
      }
    }
  }
}
