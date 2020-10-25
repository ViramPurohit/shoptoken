import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/views/login/ui/resetpasswordsuccess.dart';
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

class ResetPassword extends StatefulWidget {
  ResetPassword({@required this.retailerId, Key key}) : super(key: key);

  final int retailerId;
  @override
  State<StatefulWidget> createState() {
    return _ResetPassword();
  }
}

class _ResetPassword extends State<ResetPassword> {
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // For CircularProgressIndicator.
  bool visible = false;

  BuildContext scaffoldContext;

  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String otp, password, confirmpassword;
  bool _passwordVisible, _confpasswordVisible;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _passwordVisible = false;
    _confpasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    /*
      On Click events
    */
    Future<void> callChangePasswordAPI() async {
      var requestMap = new Map<String, dynamic>();
      requestMap['otp'] = otp;
      requestMap['retailer_id'] = widget.retailerId;
      requestMap['password'] = password;
      requestMap['app_os'] = await Util().getDeviceOS();
      requestMap['app_version'] = await Util().getAppVersion();

      print("requestMap $requestMap");
      _loginBloc.add(ResetPasswordButtonPressed(requestMap: requestMap));
    }

    void _passwordButtonClick() {
      if (_formKey.currentState.validate()) {
        // No any error in validation
        _formKey.currentState.save();

        visible = true;
        callChangePasswordAPI();
      } else {
        // validation error
        setState(() {
          visible = false;
          _validate = true;
        });
      }
    }

    String _validateOTP(String value) {
      if (value.length == 0) {
        return "OTP is Required";
      } else if (value.length != 4) {
        return "OTP must be 4 digits";
      }
      return null;
    }

    String _validatePassword(String value) {
      if (value.length == 0) {
        return "Password is Required";
      } else if (value.length < 7) {
        return "Password must greter than 7 character";
      }
      return null;
    }

    String _validateConfirmPassword(String value) {
      if (value.length == 0) {
        return "Password is Required";
      } else if (value.length < 7) {
        return "Password must greter than 7 character";
      } else if (password != confirmpassword) {
        return "New password and Confirm Password must be same";
      }
      return null;
    }

    final passwordField = TextFormField(
      obscureText: !_passwordVisible,
      style: getTextStyle(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "New Password",
        suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: _validatePassword,
      onSaved: (String val) {
        password = val;
      },
    );

    final confirmpasswordField = TextFormField(
      obscureText: !_passwordVisible,
      style: getTextStyle(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "Confirm Password",
        suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _confpasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _confpasswordVisible = !_confpasswordVisible;
              });
            }),
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: _validateConfirmPassword,
      onSaved: (String val) {
        confirmpassword = val;
      },
    );

    final resettitle = Container(
      child: new Text('Reset your password', style: getTextLargeStyle()),
    );
    final resetmsg = Container(
      child: new Text('We have sent a four digit code on your phone.',
          textAlign: TextAlign.center, style: getTextStyle()),
    );
    final otpField = TextFormField(
        obscureText: false,
        style: getTextStyle(),
        validator: _validateOTP,
        onSaved: (String val) {
          otp = val;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 4,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          labelText: "Enter OTP",
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ));

    final resetpassword = getBaseButton(
        text: 'Reset Password',
        onPressed: () async {
          _passwordButtonClick();
        });

    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is ConfirmPasswordInProgress) {
          Dialogs().showLoadingDialog(context, _keyLoader);
        }
        if (state is LoginFailure) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Util().showScaffoldErrorToast(_scaffoldKey, state.error);
        }
        if (state is LoginErrorMsg) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Util().showScaffoldErrorToast(_scaffoldKey, state.error);
        }

        if (state is ResetPasswordSuccess) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResettPasswordSuccess()));
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
                                  "assets/securepassword.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 30, bottom: 8),
                                child: resettitle,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: resetmsg,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: otpField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: passwordField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: confirmpasswordField,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 30, bottom: 8),
                                child: resetpassword,
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
