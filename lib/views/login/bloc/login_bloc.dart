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
            await apirepository.loginretailer(requestMap: event.requestMap);
        print("LoginIn result====$result");
        if (result.retailerloginresult.isError == 0) {
          yield LoginSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.retailerloginresult.message);
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
            await apirepository.registerRetailer(requestMap: event.requestMap);
        print("result====$result");
        if (result.retailerregisterResult.isError == 0) {
          yield SignupSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.retailerregisterResult.message);
        }
      } catch (error) {
        print("Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    } else if (event is UploadShopCertificate) {
      print("UploadShop Progress====");
      yield UploadShopCertificateInProgress();
      try {
        final result = await apirepository.uploadShopCerificate(
            retailerId: event.retailerId, imagePath: event.imagePath);
        print("result==UploadShopCertificate ==$result");
        if (result.uploadshopCertificateResult.isError == 0) {
          yield UploadCertificateSuccess(result);
        } else {
          yield LoginErrorMsg(
              error: result.uploadshopCertificateResult.message);
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
        final result = await apirepository.verifyretailermobile(
            requestMap: event.requestMap);

        if (result.verifyretailerresult.isError == 0) {
          yield VerifyMobileSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.verifyretailerresult.message);
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
        final result = await apirepository.resetretailerpassword(
            requestMap: event.requestMap);

        if (result.resetretailerresult.isError == 0) {
          yield ResetPasswordSuccess(result);
        } else {
          yield LoginErrorMsg(error: result.resetretailerresult.message);
        }
      } catch (error) {
        print("Error====");
        print(error);
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
