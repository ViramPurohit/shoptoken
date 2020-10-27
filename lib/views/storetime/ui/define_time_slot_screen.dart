import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/views/home/ui/home_screen.dart';
import 'package:Retailer/views/storetime/bloc/storetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/utils/util_page.dart';
import 'package:Retailer/widgets/button.dart';
import 'package:Retailer/widgets/text_style.dart';

class SelectUserSlotScreen extends StatefulWidget {
  SelectUserSlotScreen({Key key, this.retailerid}) : super(key: key);
  final int retailerid;

  @override
  _SelectTimeSlotState createState() => new _SelectTimeSlotState();
}

class _SelectTimeSlotState extends State<SelectUserSlotScreen> {
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

  StoreTimeBloc _storeTimeBloc;

  String _bookstarttime;
  String _bookendtime;

  String bookDate;

  int timeSlotValue;

  @override
  void initState() {
    super.initState();
    _storeTimeBloc = BlocProvider.of<StoreTimeBloc>(context);
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreTimeBloc, StoreTimeState>(
      listener: (BuildContext context, StoreTimeState state) {
        if (state is StoreTimeInProgress) {
          Dialogs().showLoadingDialog(context, _keyLoader);
        }
        if (state is StoreTimeFailure) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
        }

        if (state is RetailerUpdateSuccess) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          print(state.result);
          Apppreferences().addSignupLevel(3);
          Apppreferences().addLogin();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);
        }
        if (state is ShopTimeSlotSuccess) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          print(state.startTime);
          _bookstarttime = state.startTime;
          _bookendtime = state.endTime;
        }
      },
      child: BlocBuilder<StoreTimeBloc, StoreTimeState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, StoreTimeState state) {
          return Container(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 2,
                      child: SingleChildScrollView(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              child: new Text(
                                  "Select Time Slot to allow one Customer",
                                  style: getTextLargeStyle()),
                            ),
                            DropdownButton<int>(
                              value: timeSlotValue,
                              hint: Center(
                                child: Text('Select Time Slot value',
                                    textAlign: TextAlign.center),
                              ),
                              elevation: 16,
                              style: TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (int newValue) {
                                setState(() {
                                  timeSlotValue = newValue;
                                });
                              },
                              items: getSlotList()
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Center(
                                    child: Text(value.toString(),
                                        textAlign: TextAlign.center),
                                  ),
                                );
                              }).toList(),
                            ),
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: getBaseButton(
                                  onPressed: () {
                                    saveRetailer();
                                  },
                                  text: 'Save'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  Future<void> saveRetailer() async {
    var requestMap = new Map<String, dynamic>();
    requestMap['retailer_id'] = await Apppreferences().getUserId();
    requestMap['start_at'] = _bookstarttime;
    requestMap['end_at'] = _bookendtime;
    requestMap['slotvalue'] = timeSlotValue;
    requestMap['app_os'] = await Util().getDeviceOS();
    requestMap['app_version'] = await Util().getAppVersion();

    _storeTimeBloc.add(RetailerUpdateEvent(requestMap: requestMap));
  }
}
