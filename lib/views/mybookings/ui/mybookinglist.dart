import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/utils/util_page.dart';
import 'package:shoptoken/views/mybookings/bloc/mybookinglist.dart';
import 'package:shoptoken/widgets/text_style.dart';

import 'bookingList_result.dart';

class MyBookingList extends StatefulWidget {
  MyBookingList({Key key}) : super(key: key);

  @override
  _MyBookingListState createState() => new _MyBookingListState();
}

class _MyBookingListState extends State<MyBookingList> {
  List<CustomerbookingData> bookingList;
  MyBookTicketBloc _customerBloc;
  var selectedDay, selectedMonth, selectedYear, bookingdate = "Select date";
  var collectBookingMsg = "Collecting user details...";
  DateTime pickedDate;
  @override
  void initState() {
    super.initState();
    _customerBloc = BlocProvider.of<MyBookTicketBloc>(context);
    bookingList = new List<CustomerbookingData>();

    pickedDate = DateTime.now();
    getMyBookings(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyBookTicketBloc, MyBookingListState>(
      listener: (BuildContext context, MyBookingListState state) {
        if (state is MyBookingListSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          if (state.result.customerbookingresult.isError == 0) {
            bookingList = state.result.customerbookingresult.data;
          } else {
            bookingList = new List<CustomerbookingData>();
            collectBookingMsg = state.result.customerbookingresult.message;
            Util().showToast(context, collectBookingMsg);
          }
        }
        if (state is MyBookingListInProgress) {
          Dialogs().showLoaderDialog(context);
        }

        if (state is MyBookingListFailure) {
          Dialogs().dismissLoaderDialog(context);
          Util().showErrorToast(context, state.error);
        }
        if (state is AddToFavInProgress) {
          Dialogs().showLoaderDialog(context);
        }
        if (state is AddToFavButtonSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          Util().showToast(context, state.result.userfavoriteresult.message);
        }
      },
      child: BlocBuilder<MyBookTicketBloc, MyBookingListState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, MyBookingListState state) {
          return Container(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10, bottom: 10),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.brown, width: 2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(right: 5.0),
                                      child: new Icon(Icons.calendar_today)),
                                  new Text(
                                    bookingdate,
                                    style: getTextStyle()
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      child: new Icon(Icons.arrow_drop_down)),
                                ],
                              ),
                            ),
                            onTap: () {
                              callDatePicker();
                            },
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: bookingList.isEmpty
                                  ? Container(
                                      width: 500,
                                      height: 500,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10,
                                            bottom: 10),
                                        margin: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Text(
                                              collectBookingMsg,
                                              style: getTextLargeStyle()
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : MyBookingListResult(
                                      bookingList: bookingList,
                                      callback: callback,
                                    )),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      getMyBookings(order);
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  void getMyBookings(DateTime order) async {
    selectedDay = order.day;
    selectedMonth = order.month;
    selectedYear = order.year;
    setState(() {
      bookingdate = "$selectedYear-$selectedMonth-$selectedDay";
    });

    var requestMap = new Map<String, dynamic>();
    requestMap['customer_id'] = await Apppreferences().getUserId();
    requestMap['booking_date'] = bookingdate.toString();

    _customerBloc.add(MyBookingEventListEvent(requestMap: requestMap));
  }

  callback(retailerId) {
    setState(() {
      print('Booking date $retailerId ');
      addToFavourite(retailerId);
    });
  }

  Future<void> addToFavourite(retailerId) async {
    var requestMap = new Map<String, dynamic>();
    requestMap['customer_id'] = await Apppreferences().getUserId();
    requestMap['retailer_id'] = retailerId;
    bookingList = new List<CustomerbookingData>();
    _customerBloc.add(AddToFavButtonEvent(requestMap: requestMap));
  }
}
