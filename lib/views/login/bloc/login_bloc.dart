import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_repository.dart';
import 'package:shoptoken/views/login/bloc/login_event.dart';
import 'package:shoptoken/views/login/bloc/login_states.dart';

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
            await apirepository.logincustomer(requestMap: event.requestMap);
        print("LoginIn result====$result");
        if (result.customerloginresult.isError == 0) {
          yield LoginSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.customerloginresult.message);
        }
      } catch (error) {
        print("LoginIn Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    } else if (event is SignupButtonPressed) {
      yield SignupInProgress();
      print("SignupInProgress====");
      try {
        final result =
            await apirepository.registerUser(requestMap: event.requestMap);
        print("result====$result");
        if (result.customerregisterResult.isError == 0 ||
            result.customerregisterResult.isError == 1) {
          yield SignupSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.customerregisterResult.message);
        }
      } catch (error) {
        print("Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    } else if (event is VerifyMobileButtonPressed) {
      print("VerifyMobileButto Progress====");
      yield VerifyRetailerInProgress();
      try {
        final result = await apirepository.verifycustomermobile(
            requestMap: event.requestMap);

        if (result.verifycustomerresult.isError == 0) {
          yield VerifyMobileSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.verifycustomerresult.message);
        }
      } catch (error) {
        print("Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    } else if (event is ResetPasswordButtonPressed) {
      print("ResetPassword Progress====");
      yield ConfirmPasswordInProgress();
      try {
        final result = await apirepository.resetcustomerpassword(
            requestMap: event.requestMap);

        if (result.resetcustomerresult.isError == 0) {
          yield ResetPasswordSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.resetcustomerresult.message);
        }
      } catch (error) {
        print("Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
