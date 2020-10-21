import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/dialog.dart';
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
  @override
  void initState() {
    super.initState();
    _userprofileBloc = BlocProvider.of<UserprofileBloc>(context);
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
          return SnackBar(
            content: Text(state.error),
            backgroundColor: Theme.of(context).errorColor,
          );
        }
        if (state is RetailerdetailSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
        }
      },
      child: BlocBuilder<UserprofileBloc, UserprofileState>(
        builder: (BuildContext context, UserprofileState state) {
          return Container(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 40, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          'Change shop slot amount',
                          style: getTextStyle()
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: new Icon(Icons.chevron_right))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 40, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          'Add holiday for today',
                          style: getTextStyle()
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: new Icon(Icons.chevron_right))
                      ],
                    ),
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
