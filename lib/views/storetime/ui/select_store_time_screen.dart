import 'package:Retailer/utils/util_page.dart';
import 'package:Retailer/views/storetime/bloc/storetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/widgets/text_style.dart';

class SelectStoreSrtEndTime extends StatefulWidget {
  SelectStoreSrtEndTime({Key key}) : super(key: key);

  @override
  _SelectStoreTimeScreenState createState() =>
      new _SelectStoreTimeScreenState();
}

class _SelectStoreTimeScreenState extends State<SelectStoreSrtEndTime> {
  var opentime = 'Select opening time';
  var closetime = 'Select closing time';

  int opentimeTO, closetimeTO;

  StoreTimeBloc _storeTimeBloc;

  @override
  void initState() {
    super.initState();
    _storeTimeBloc = BlocProvider.of<StoreTimeBloc>(context);
  }

  void callTimePicker(bool isFromStarTime) async {
    var _selectTime = await getDate();
    setState(() {
      if (isFromStarTime) {
        opentimeTO = _selectTime.hour + _selectTime.minute;
        print('opentimeTO  == $opentimeTO');
        if (closetimeTO != null) {
          if (opentimeTO > closetimeTO) {
            Util().showToast(
                context, 'Shop open time should lesser than close time');
          } else {
            opentime = Util().formatTimeOfDay(_selectTime);
          }
        } else {
          opentime = Util().formatTimeOfDay(_selectTime);
        }
      } else {
        closetimeTO = _selectTime.hour + _selectTime.minute;
        print('closetimeTO == $closetimeTO');
        if (opentimeTO != null) {
          if (opentimeTO > closetimeTO) {
            Util().showToast(
                context, 'Shop close time should greater than open time');
          } else {
            closetime = Util().formatTimeOfDay(_selectTime);
          }
        } else {
          closetime = Util().formatTimeOfDay(_selectTime);
        }
      }

      print('closetime  == $closetime');
      print('opentime  == $opentime');
      if (opentimeTO != null && closetimeTO != null) {
        _storeTimeBloc
            .add(SelectTimeSlot(startTime: opentime, endTime: closetime));
      }
    });
  }

  Future<TimeOfDay> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 10, bottom: 10),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: new Icon(Icons.timer)),
                    new Text(
                      opentime,
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onTap: () {
                callTimePicker(true);
              },
            ),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 10, bottom: 10),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: new Icon(Icons.timer)),
                    new Text(
                      closetime,
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onTap: () {
                callTimePicker(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
