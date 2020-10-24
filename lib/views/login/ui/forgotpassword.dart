import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/views/login/ui/resetpassword.dart';
import 'package:Retailer/views/login/ui/signup_page.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/service/firebasenotifications.dart';
import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/util_page.dart';

import 'package:Retailer/views/category/ui/category_screen.dart';
import 'package:Retailer/views/login/bloc/login.dart';

import 'package:Retailer/widgets/button.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword> {
  // For CircularProgressIndicator.
  bool visible = false;

  BuildContext scaffoldContext;

  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String mobile, password;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    new NotificationHandler().initializeFcmNotification();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    /*
      On Click events
    */
    Future<void> callLoginAPI() async {
      var requestMap = new Map<String, dynamic>();
      requestMap['mobile_no'] = mobile;
      requestMap['password'] = password;
      requestMap['push_token'] = await Apppreferences().getAppToken();
      requestMap['app_os'] = await Util().getDeviceOS();
      requestMap['app_version'] = await Util().getAppVersion();

      print("requestMap $requestMap");
      _loginBloc.add(LoginButtonPressed(requestMap: requestMap));
    }

    void _loginButtonClick() {
      if (_formKey.currentState.validate()) {
        // No any error in validation
        _formKey.currentState.save();

        visible = true;
        callLoginAPI();
      } else {
        // validation error
        setState(() {
          visible = false;
          _validate = true;
        });
      }
    }

    String _validateMobile(String value) {
      String patttern = r'(^[0-9]*$)';
      RegExp regExp = new RegExp(patttern);
      if (value.length == 0) {
        return "Mobile is Required";
      } else if (value.length != 10) {
        return "Mobile number must 10 digits";
      } else if (!regExp.hasMatch(value)) {
        return "Mobile Number must be digits";
      }
      return null;
    }

    final mobileField = TextFormField(
        obscureText: false,
        style: getTextStyle(),
        validator: _validateMobile,
        onSaved: (String val) {
          mobile = val;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 10,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          labelText: "Enter Mobile no",
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ));

    final sendOTP = getBaseButton(
        text: 'Continue',
        onPressed: () async {
          // _loginButtonClick();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPassword()));
        });

    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginInProgress) {
          Dialogs().showLoaderDialog(context);
        }
        if (state is LoginFailure) {
          Dialogs().dismissLoaderDialog(context);
          return SnackBar(
            content: Text(state.error),
            backgroundColor: Theme.of(context).errorColor,
          );
        }
        if (state is LoginErrorMsg) {
          Dialogs().dismissLoaderDialog(context);
          return SnackBar(
            content: Text(state.error),
            backgroundColor: Theme.of(context).errorColor,
          );
        }
        if (state is LoginSuccess) {
          Dialogs().dismissLoaderDialog(context);
          Apppreferences().addUserLogin(state.result);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoryScreen()));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        // bloc: BlocProvider.of<LoginBloc>(context),
        builder: (BuildContext context, LoginState state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: new Builder(builder: (BuildContext context) {
              scaffoldContext = context;
              return new Center(
                child: ScrollConfiguration(
                  behavior: new ScrollBehavior()
                    ..buildViewportChrome(context, null, AxisDirection.up),
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Form(
                        key: _formKey,
                        autovalidate: _validate,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 155.0,
                                child: Image.asset(
                                  "assets/forgotpassword.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 30, bottom: 8),
                                child: mobileField,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 30, bottom: 8),
                                child: sendOTP,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
