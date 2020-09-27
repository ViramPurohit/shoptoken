import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_bloc.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_event.dart';
import 'package:shoptoken/widgets/text_style.dart';

class DateSlotPicker extends StatefulWidget {
  DateSlotPicker({Key key, @required this.retailerid}) : super(key: key);

  final int retailerid;

  @override
  _DateSlotPickerState createState() => new _DateSlotPickerState();
}

class _DateSlotPickerState extends State<DateSlotPicker> {
  var selectedDay, selectedMonth, selectedYear;
  DateTime pickedDate;

  BookTicketBloc _bookTicketBloc;

  @override
  void initState() {
    super.initState();
    _bookTicketBloc = BlocProvider.of<BookTicketBloc>(context);
    pickedDate = DateTime.now();
    selectedDay = pickedDate.day;
    selectedMonth = pickedDate.month;
    selectedYear = pickedDate.year;
  }

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      selectedDay = order.day;
      selectedMonth = order.month;
      selectedYear = order.year;
      var requestMap = new Map<String, dynamic>();
      requestMap['retailer_id'] = widget.retailerid;
      requestMap['booking_date'] = "$selectedYear-$selectedMonth-$selectedDay";
      _bookTicketBloc.add(SelectDayButtonEvent(requestMap: requestMap));
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
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
                    border: Border.all(color: Colors.brown, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: new Icon(Icons.calendar_today)),
                    new Text(
                      'Select a day',
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onTap: () {
                callDatePicker();
              },
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2)),
                      child: new Text("$selectedDay")),
                  Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2)),
                      child: new Text("$selectedMonth")),
                  Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2)),
                      child: new Text("$selectedYear", style: getTextStyle())),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
