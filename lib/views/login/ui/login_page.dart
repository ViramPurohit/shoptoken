import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/views/home/ui/home_screen.dart';
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

import 'forgotpassword.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

    String _validatePassword(String value) {
      if (value.length == 0) {
        return "Password is Required";
      } else if (value.length < 7) {
        return "Password must greter than 7 character";
      }
      return null;
    }

    final passwordField = TextFormField(
      obscureText: true,
      style: getTextStyle(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "Enter Password",
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

    final signUpField = InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
        child: new Text('SignUp', style: getTextLargeStyle()),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupPage()));
      },
    );

    final forgotPasswordField = InkWell(
      child: Container(
        child: new Text('Forgot Password', style: getTextLargeStyle()),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgotPassword()));
      },
    );
    final loginButon = getBaseButton(
        text: 'Login',
        onPressed: () async {
          _loginButtonClick();
        });

    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginInProgress) {
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
        if (state is LoginSuccess) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Apppreferences().addUserLogin(state.result.retailerloginresult.id,
              state.result.retailerloginresult.shopName);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              body: new Center(
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
                                  "assets/shop.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: mobileField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: passwordField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: loginButon,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: signUpField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: forgotPasswordField,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
