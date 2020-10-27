import 'package:Retailer/models/retailerdetailresult.dart';
import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/utils/util_page.dart';
import 'package:Retailer/views/userprofile/bloc/userprofile.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatefulWidget {
  //requiring the list of todos
  UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => new _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserprofileBloc _userprofileBloc;
  List<RetailerData> retailer;
  @override
  void initState() {
    super.initState();
    _userprofileBloc = BlocProvider.of<UserprofileBloc>(context);
    retailer = new List<RetailerData>();
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
        if (state is RetailerdetailSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          if (state.result.retailerdetailresult.isError == 0) {
            retailer = state.result.retailerdetailresult.data;
          } else {
            Util()
                .showToast(context, state.result.retailerdetailresult.message);
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
                          child: new Text(
                            retailer[0].fullName,
                            style: getTextStyle()
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            retailer[0].shopName,
                            style: getTextStyle()
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            retailer[0].mobileNo,
                            style: getTextStyle()
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: new Text(
                              retailer[0].shopLicense,
                              style: getTextStyle()
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: new Text(
                              retailer[0].startAt + " TO " + retailer[0].endAt,
                              style: getTextStyle()
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          )),
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
                      "No profile added",
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
    requestMap['retailer_id'] = await Apppreferences().getUserId();
    _userprofileBloc.add(UserDetailsEvent(requestMap: requestMap));
  }
}
