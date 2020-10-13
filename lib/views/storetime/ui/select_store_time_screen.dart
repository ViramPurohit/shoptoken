import 'package:Retailer/utils/util_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/views/booktickets/bloc/bookticket_bloc.dart';
import 'package:Retailer/views/booktickets/bloc/bookticket_event.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:intl/intl.dart';

class SelectStoreSrtEndTime extends StatefulWidget {
  SelectStoreSrtEndTime({Key key}) : super(key: key);

  @override
  _SelectStoreTimeScreenState createState() =>
      new _SelectStoreTimeScreenState();
}

class _SelectStoreTimeScreenState extends State<SelectStoreSrtEndTime> {
  var selectedDay, selectedMonth, selectedYear;
  DateTime pickedDate;

  BookTicketBloc _bookTicketBloc;

  var opentime = 'Select opening time';
  var closetime = 'Select closing time';

  @override
  void initState() {
    super.initState();
    _bookTicketBloc = BlocProvider.of<BookTicketBloc>(context);
    pickedDate = DateTime.now();
    // selectedDay = pickedDate.day;
    // selectedMonth = pickedDate.month;
    // selectedYear = pickedDate.year;
    // var bookDate = "$selectedYear-$selectedMonth-$selectedDay";
    // _bookTicketBloc.add(SelectDateEvent(bookDate: bookDate));
  }

  void callTimePicker(bool isFromStarTime) async {
    var order = await getDate();
    setState(() {
      // selectedDay = order;
      // selectedMonth = order.hour;
      // selectedYear = order.minute;

      // var bookDate = "$selectedYear-$selectedMonth-$selectedDay";
      if (isFromStarTime) {
        opentime = Util().formatTimeOfDay(order);
      } else {
        closetime = Util().formatTimeOfDay(order);
      }
      // DateTime myopentime = DateTime.parse(opentime);
      // DateTime myclosetime = DateTime.parse(closetime);
      // DateTime myopentime = DateFormat.jm()
      //     .format(DateFormat("hh:mm a").parse(opentime)) as DateTime;
      // DateTime myclosetime = DateFormat.jm()
      //     .format(DateFormat("hh:mm a").parse(closetime)) as DateTime;

      // print("object $myopentime");
      // print("object $myclosetime");
      // print("object ${myclosetime.isAfter(myopentime)}");
      // _bookTicketBloc.add(SelectDateEvent(bookDate: bookDate));
      // var requestMap = new Map<String, dynamic>();
      // requestMap['retailer_id'] = 1;
      // requestMap['booking_date'] = bookDate;
      // _bookTicketBloc.add(SelectDayButtonEvent(requestMap: requestMap));
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
