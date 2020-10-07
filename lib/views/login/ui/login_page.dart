import 'package:Retailer/widgets/textinputdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Retailer/service/firebasenotifications.dart';
import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/util_page.dart';

import 'package:Retailer/views/category/ui/category_screen.dart';
import 'package:Retailer/views/login/bloc/login.dart';
import 'package:Retailer/views/userlocation/ui/user_location.dart';

import 'package:Retailer/widgets/button.dart';

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

  BuildContext scaffoldContext;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);

  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String locationLabel = 'Location';
  String uploadlicenceLabel = 'Upload shop licence or doc';
  String fullname, mobile, location, storename;

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
      requestMap['full_name'] = fullname;
      requestMap['address'] = location;

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
        fullname = val;
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

    _navigateToUserLocation(BuildContext context) async {
      final userLocationDetails = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserLocation()),
      );
      // UserLocationDetails details = new UserLocationDetails
      location = userLocationDetails.address;
      print('==userLocationDetails=== $location');
      locationLabel = location;
      setState(() {});
    }

    final locationField = InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: new BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          children: <Widget>[
            Flexible(child: new Text(locationLabel, style: style)),
          ],
        ),
      ),
      onTap: () {
        _navigateToUserLocation(context);
      },
    );

    final shopNameField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "Enter store Name",
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: _validateName,
      onSaved: (String val) {
        storename = val;
      },
    );
    final uploadlicenceField = InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: new BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          children: <Widget>[
            Flexible(child: new Text(locationLabel, style: style)),
          ],
        ),
      ),
      onTap: () {
        _navigateToUserLocation(context);
      },
    );

    final loginButon = getBaseButton(
        text: 'Login',
        onPressed: () async {
          // if (location == null || location.isEmpty) {
          //   Util.showSnackbar(scaffoldContext, 'Please enter location details');
          // } else {
          //   _loginButtonClick();
          // }

          final result = await displayInputDialog(
            context: context,
            text: 'Enter Confimation Code',
            onPressed: () {
              setState(() {
                print('Result---- On finish');
              });
            },
          );
          print('Result---- $result');
        });

    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccess) {
          Apppreferences().addUserLogin(state.result);
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
          if (state is LoginErrorMsg) {
            return SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            );
          }
          return Scaffold(
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
                                  "assets/shop.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: nameField,
                              ),
                              // SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: mobileField,
                              ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: locationField,
                              ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: shopNameField,
                              ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: uploadlicenceField,
                              ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: loginButon,
                              ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
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
