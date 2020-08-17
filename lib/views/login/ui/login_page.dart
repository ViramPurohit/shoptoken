import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/utils/apppreferences.dart';

import 'package:shoptoken/views/category/ui/category_screen.dart';
import 'package:shoptoken/views/login/bloc/login.dart';
import 'package:shoptoken/views/userlocation/ui/user_location.dart';

import 'package:shoptoken/widgets/button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  // For CircularProgressIndicator.
  bool visible = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);

  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String name, mobile, location;

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    /*
      On Click events
    */
    void callLoginAPI() {
      _loginBloc.add(LoginButtonPressed(name: name));
    }

    void _loginButtonClick() {
      if (_formKey.currentState.validate()) {
        // No any error in validation
        _formKey.currentState.save();
        print("Name $name");
        print("Name $mobile");
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

    String _validateName(String value) {
      if (value.length == 0) {
        return "Name is Required";
      }
      return null;
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

    String _validateLocation(String value) {
      if (value.length == 0) {
        return "Please enter location details";
      }
      return null;
    }

    final nameField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "Enter Name",
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: _validateName,
      onSaved: (String val) {
        name = val;
      },
    );

    final mobileField = TextFormField(
      obscureText: false,
      style: style,
      validator: _validateMobile,
      onSaved: (String val) {
        mobile = val;
      },
      maxLength: 10,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "Enter Mobile no",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
    );

    final locationField = TextFormField(
      obscureText: false,
      style: style,
      validator: _validateLocation,
      onSaved: (String val) {
        location = val;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "Location",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
    final loginButon = getBaseButton(
        text: 'Login',
        onPressed: () {
          _loginButtonClick();
          // Navigator.push(context,
          // MaterialPageRoute(builder: (context) => CategoryScreen()));

          // Navigator.of(context).pushReplacementNamed('/categoryscreen');
        });
    final locationButon = getBaseButton(
        text: 'Location Buton',
        onPressed: () {
          Apppreferences().addUserLogin();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserLocation()));

          // Navigator.of(context).pushReplacementNamed('/categoryscreen');
        });
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccess) {
          print(state.result.token);
          Apppreferences().addUserLogin();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoryScreen()));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        // bloc: BlocProvider.of<LoginBloc>(context),
        builder: (BuildContext context, LoginState state) {
          if (state is LoginInProgress) {
            return Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(child: CircularProgressIndicator()));
          }
          if (state is LoginFailure) {
            return SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            );
          }
          return Scaffold(
            body: Center(
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
                        padding: const EdgeInsets.all(36.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 155.0,
                              child: Image.asset(
                                "assets/team.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 25.0),
                            nameField,
                            SizedBox(height: 25.0),
                            mobileField,
                            SizedBox(
                              height: 25.0,
                            ),
                            locationField,
                            SizedBox(
                              height: 25.0,
                            ),
                            loginButon,
                            SizedBox(
                              height: 15.0,
                            ),
                            locationButon,
                            SizedBox(
                              height: 15.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
