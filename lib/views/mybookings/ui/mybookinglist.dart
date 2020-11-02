import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/utils/util_page.dart';
import 'package:shoptoken/views/mybookings/bloc/mybookinglist.dart';

import 'bookingList_result.dart';

class MyBookingList extends StatefulWidget {
  MyBookingList({Key key}) : super(key: key);

  @override
  _MyBookingListState createState() => new _MyBookingListState();
}

class _MyBookingListState extends State<MyBookingList> {
  List<CustomerbookingData> bookingList;
  MyBookTicketBloc _customerBloc;

  @override
  void initState() {
    super.initState();
    _customerBloc = BlocProvider.of<MyBookTicketBloc>(context);
    bookingList = new List<CustomerbookingData>();

    submitCategory();
  }

  Future<void> submitCategory() async {
    DateTime now = new DateTime.now();
    var bookingdate = "${now.year}-${now.month}-${now.day}";
    var requestMap = new Map<String, dynamic>();
    requestMap['customer_id'] = await Apppreferences().getUserId();
    requestMap['booking_date'] = bookingdate.toString();

    _customerBloc.add(MyBookingEventListEvent(requestMap: requestMap));
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
            Util()
                .showToast(context, state.result.customerbookingresult.message);
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
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: bookingList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text('Collecting user details'))
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

    _customerBloc.add(AddToFavButtonEvent(requestMap: requestMap));
  }
}
