import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/utils/util_page.dart';
import 'package:Retailer/views/setting/bloc/setting.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SettingOptions extends StatefulWidget {
  //requiring the list of todos
  SettingOptions({Key key}) : super(key: key);

  @override
  _SettingOptionsState createState() => new _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
  SettingBloc _settingBloc;
  @override
  void initState() {
    super.initState();
    _settingBloc = BlocProvider.of<SettingBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (BuildContext context, SettingState state) {
        if (state is SettingProgress) {
          Dialogs().showLoaderDialog(context);
        }
        if (state is SettingFailure) {
          Dialogs().dismissLoaderDialog(context);
          return SnackBar(
            content: Text(state.error),
            backgroundColor: Theme.of(context).errorColor,
          );
        }

        if (state is ChangeSlotValueSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => HomeScreen()),
          //     (Route<dynamic> route) => false);
        }
        if (state is EnableHolidaySuccess) {
          Dialogs().dismissLoaderDialog(context);
        }
      },
      child: BlocBuilder<SettingBloc, SettingState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, SettingState state) {
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
                  onTap: () {
                    showSlotList(context);
                  },
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
                  onTap: () {
                    dialogwithbutton(
                        context, 'Add holiday', 'Today,You shop is close ?');
                  },
                )
              ],
            ))),
          );
        },
      ),
    );
  }

  List<int> getSlotList() {
    var list = List<int>();
    for (var i = 1; i <= 60; i++) {
      if (i % 5 == 0) {
        list.add(i);
      }
    }

    return list;
  }

  Future<void> showSlotList(BuildContext context) async {
    var value = await Dialogs().selectTimeSlot(context, getSlotList());

    print("value Final $value");
    var requestMap = new Map<String, dynamic>();
    requestMap['retailer_id'] = await Apppreferences().getUserId();
    requestMap['slotvalue'] = value;
    requestMap['app_os'] = await Util().getDeviceOS();
    requestMap['app_version'] = await Util().getAppVersion();
    _settingBloc.add(ChangeSlotValueEvent(requestMap: requestMap));
  }

  Future<void> dialogwithbutton(BuildContext context, title, msg) async {
    var isholiday = await Dialogs().dialogwithbutton(context, title, msg);
    print("value Final $isholiday");

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    var requestMap = new Map<String, dynamic>();
    requestMap['retailer_id'] = await Apppreferences().getUserId();
    requestMap['isCloseToday'] = isholiday ? 0 : 1;
    requestMap['holiday_date'] = formattedDate;
    requestMap['app_os'] = await Util().getDeviceOS();
    requestMap['app_version'] = await Util().getAppVersion();
    _settingBloc.add(EnableHolidayEvent(requestMap: requestMap));
  }
}
