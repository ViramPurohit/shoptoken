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

      try {
        final result = await apirepository.registerUser(name: event.name);
        yield LoginSuccess(result);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
