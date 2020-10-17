import 'package:Retailer/models/retailerallbookings.dart';

import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/utils/util_page.dart';
import 'package:Retailer/views/customerlist/bloc/customer_bloc.dart';
import 'package:Retailer/views/customerlist/bloc/customer_event.dart';
import 'package:Retailer/views/customerlist/bloc/customer_state.dart';
import 'package:Retailer/widgets/textinputdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customerList_result.dart';

class CustomerList extends StatefulWidget {
  CustomerList({Key key}) : super(key: key);

  @override
  _CustomerListState createState() => new _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<RetailerbookinData> bookingList;
  CustomerBloc _customerBloc;

  @override
  void initState() {
    super.initState();
    _customerBloc = BlocProvider.of<CustomerBloc>(context);
    bookingList = new List<RetailerbookinData>();

    submitCategory();
  }

  Future<void> submitCategory() async {
    DateTime now = new DateTime.now();
    var bookingdate = "${now.year}-${now.month}-${now.day}";
    var requestMap = new Map<String, dynamic>();
    // requestMap['retailer_id'] = await Apppreferences().getUserId();
    // requestMap['booking_date'] = bookingdate.toString();
    requestMap['retailer_id'] = 11;
    requestMap['booking_date'] = "2020-10-03";

    _customerBloc.add(CustomerListEvent(requestMap: requestMap));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (BuildContext context, CustomerState state) {
        if (state is CustomerSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          if (state.result.retailerbookingresult.isError == 0) {
            bookingList = state.result.retailerbookingresult.data;
          } else {
            Util()
                .showToast(context, state.result.retailerbookingresult.message);
          }
        }
        if (state is CustomerProgress) {
          Dialogs().showLoaderDialog(context);
        }
        if (state is CodeVerificationSuccess) {
          Dialogs().dismissLoaderDialog(context);
          if (state.result.verifyCoderesult.isError == 0) {
            Dialogs().showAlertMsgDialog(
                context, "Confirm Code", state.result.verifyCoderesult.message);
          } else {
            Util().showToast(context, state.result.verifyCoderesult.message);
          }
        }
        if (state is CustomerFailure) {
          Dialogs().dismissLoaderDialog(context);
          Util().showErrorToast(context, state.error);
        }
      },
      child: BlocBuilder<CustomerBloc, CustomerState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, CustomerState state) {
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
                                  : CustomerListResult(
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

  void showConfirmDialog() {
    new AlertDialog(
      title: new Text("Logout"),
      content: new Text("Do you want to Logout?"),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  callback(bookId) {
    setState(() {
      print('Booking date $bookId ');
      showCodeEnterDialog(bookId);
    });
  }

  Future<void> showCodeEnterDialog(bookId) async {
    final confirmCode = await displayInputDialog(
      context: context,
      text: 'Enter Confimation Code',
      onPressed: () {
        setState(() {
          print('Result---- On finish');
        });
      },
    );
    print('Result---- $confirmCode');
    if (confirmCode != null) {
      submitUserCode(bookId, confirmCode);
    }
  }

  Future<void> submitUserCode(bookId, confirmCode) async {
    var requestMap = new Map<String, dynamic>();
    requestMap['book_id'] = bookId;
    requestMap['confirm_code'] = confirmCode;

    _customerBloc.add(EnterCodeButtonEvent(requestMap: requestMap));
  }
}
