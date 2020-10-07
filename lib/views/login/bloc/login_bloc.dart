import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/repositories/api_repository.dart';
import 'package:Retailer/views/login/bloc/login_event.dart';
import 'package:Retailer/views/login/bloc/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final APIRepository apirepository;

  LoginBloc({@required this.apirepository}) : super(LoginInitial());

  // @override
  // LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      print("LoginInProgress====");
      try {
        final result =
            await apirepository.registerUser(requestMap: event.requestMap);
        print("result====$result");
        if (result.isError == 0) {
          yield LoginSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.message);
        }
      } catch (error) {
        print("Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
