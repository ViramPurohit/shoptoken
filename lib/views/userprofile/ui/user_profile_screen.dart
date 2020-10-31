import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/getcustomerdetailresponse.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/utils/util_page.dart';
import 'package:shoptoken/views/userprofile/bloc/userprofile.dart';
import 'package:shoptoken/widgets/text_style.dart';

class UserProfilePage extends StatefulWidget {
  //requiring the list of todos
  UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => new _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserprofileBloc _userprofileBloc;
  List<CustomerData> retailer;
  @override
  void initState() {
    super.initState();
    _userprofileBloc = BlocProvider.of<UserprofileBloc>(context);
    retailer = new List<CustomerData>();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserprofileBloc, UserprofileState>(
      listener: (BuildContext context, UserprofileState state) {
        if (state is UserprofileProgress) {
          Dialogs().showLoaderDialog(context);
        }
        if (state is UserprofileFailure) {
          Dialogs().dismissLoaderDialog(context);
          Util().showErrorToast(context, state.error);
        }
        if (state is CustomerdetailSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          if (state.result.getcustomerdetailresult.isError == 0) {
            retailer = state.result.getcustomerdetailresult.data;
          } else {
            Util().showToast(
                context, state.result.getcustomerdetailresult.message);
          }
        }
      },
      child: BlocBuilder<UserprofileBloc, UserprofileState>(
        builder: (BuildContext context, UserprofileState state) {
          if (retailer.isNotEmpty)
            return Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ImageIcon(
                                    AssetImage('assets/icons/user.png'),
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  retailer[0].fullName,
                                  style: getTextStyle()
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ]))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                  AssetImage('assets/icons/home_address.png'),
                                  size: 24,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                retailer[0].address,
                                style: getTextStyle()
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                  AssetImage('assets/icons/phone_call.png'),
                                  size: 24,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                retailer[0].mobileNo,
                                style: getTextStyle()
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ])),
                      ),
                    ],
                  )),
                ),
              ),
            );
          else
            return Container(
              child: SingleChildScrollView(
                  child: Container(
                      child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Collecting details.....",
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ))),
            );
        },
      ),
    );
  }

  Future<void> getUserProfile() async {
    var requestMap = new Map<String, dynamic>();
    requestMap['customer_id'] = await Apppreferences().getUserId();
    _userprofileBloc.add(UserDetailsEvent(requestMap: requestMap));
  }
}
