import 'dart:io';

import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/views/photo/takephoto.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/service/firebasenotifications.dart';
import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/util_page.dart';

import 'package:Retailer/views/category/ui/category_screen.dart';
import 'package:Retailer/views/login/bloc/login.dart';
import 'package:Retailer/views/userlocation/ui/user_location.dart';

import 'package:Retailer/widgets/button.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  // For CircularProgressIndicator.
  bool visible = false;

  BuildContext scaffoldContext;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);

  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String locationLabel = 'Shop Location';
  double latitude, longitude;
  String uploadlicenceLabel = 'Upload shop licence or doc';
  String fullname, mobile, shopname, location, storelicencePath, password;

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
      requestMap['shop_name'] = shopname;
      requestMap['address'] = location;

      requestMap['lat'] = latitude;
      requestMap['lng'] = longitude;

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

    String _validatePassword(String value) {
      if (value.length == 0) {
        return "Password is Required";
      } else if (value.length != 7) {
        return "Password must greter than 7 character";
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

    final passwordField = TextFormField(
      obscureText: true,
      style: getTextStyle(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        labelText: "New Password",
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
    _navigateToUserLocation(BuildContext context) async {
      final userLocationDetails = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserLocation()),
      );
      // UserLocationDetails details = new UserLocationDetails
      location = userLocationDetails.address;
      latitude = userLocationDetails.latitude;
      longitude = userLocationDetails.longitude;

      print('==userLocationDetails=== $location');
      print('==userLocationDetails=== $latitude');

      locationLabel = location;
      setState(() {});
    }

    Future<void> callShopLicenceAPI(storelicencePath, int id) async {
      _loginBloc.add(
          UploadShopCertificate(retailerId: id, imagePath: storelicencePath));
    }

    _navigateToCamera(BuildContext context) async {
      // Ensure that plugin services are initialized so that `availableCameras()`
      // can be called before `runApp()`
      WidgetsFlutterBinding.ensureInitialized();

      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;

      storelicencePath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: firstCamera)),
      );

      uploadlicenceLabel = File(storelicencePath).path.split('/').last;

      print('==storename imagePath $storelicencePath');
      print('==storename name $uploadlicenceLabel');

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
        labelText: "Enter Shop Name",
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: _validateName,
      onSaved: (String val) {
        shopname = val;
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
            Flexible(child: new Text(uploadlicenceLabel, style: style)),
          ],
        ),
      ),
      onTap: () {
        _navigateToCamera(context);
      },
    );

    final loginButon = getBaseButton(
        text: 'Signup',
        onPressed: () async {
          if (location == null || location.isEmpty) {
            Util.showSnackbar(scaffoldContext, 'Please enter location details');
          } else if (storelicencePath == null || storelicencePath.isEmpty) {
            Util.showSnackbar(scaffoldContext, 'Please attach store details');
          } else {
            _loginButtonClick();
          }
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
          callShopLicenceAPI(
              storelicencePath, state.result.retailerregisterResult.id);
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
                                  "assets/shop.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: nameField,
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
                                child: locationField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: shopNameField,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: uploadlicenceField,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 30, bottom: 8),
                                child: loginButon,
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
