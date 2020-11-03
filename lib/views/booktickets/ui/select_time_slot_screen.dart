import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/utils/util_page.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_bloc.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_event.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_state.dart';
import 'package:shoptoken/views/booktickets/ui/book_confirm.dart';
import 'package:shoptoken/views/home/ui/home_screen.dart';
import 'package:shoptoken/widgets/button.dart';
import 'package:shoptoken/widgets/text_style.dart';

import 'book_ticket_result.dart';

class SelectTimeSlotScreen extends StatefulWidget {
  SelectTimeSlotScreen({Key key, this.retailerid}) : super(key: key);
  final int retailerid;

  @override
  _SelectTimeSlotState createState() => new _SelectTimeSlotState();
}

class _SelectTimeSlotState extends State<SelectTimeSlotScreen> {
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List<SlotData> slotsList;

  BookTicketBloc _bookTicketBloc;

  String _bookstarttime;
  String _bookendtime;

  String bookDate;

  @override
  void initState() {
    super.initState();
    _bookTicketBloc = BlocProvider.of<BookTicketBloc>(context);

    slotsList = new List<SlotData>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookTicketBloc, BookTicketState>(
      listener: (BuildContext context, BookTicketState state) {
        if (state is SlotListInProgress) {
          Dialogs().showLoadingDialog(context, _keyLoader);
        }
        if (state is SlotListFailure) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Util().showErrorToast(context, state.error);
        }
        if (state is BookTicketInProgress) {
          Dialogs().showLoadingDialog(context, _keyLoader);
        }
        if (state is BookTicketFailure) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Util().showErrorToast(context, state.error);
        }
        if (state is SlotListSuccess) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          print(state.result);
          slotsList = state.result.nearshopresult.data;
        }
        if (state is SelectDateSuccess) {
          print(state.bookDate);
          bookDate = state.bookDate;
        }
        if (state is BookTicketSuccess) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          if (state.result.bookingresult.isError == 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        BookConfirmScreen(bookSlotsResponse: state.result)),
                (Route<dynamic> route) => false);
          } else {
            Util().showErrorToast(context, state.result.bookingresult.message);
          }
        }
      },
      child: BlocBuilder<BookTicketBloc, BookTicketState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, BookTicketState state) {
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
                              child: new Text("Select Available Time Slot",
                                  style: getTextLargeStyle()),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: BookTicketResult(
                                  slotsList: slotsList,
                                  callback: callback,
                                )),
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: getBaseButton(
                                  onPressed: () {
                                    bookTicket();
                                  },
                                  text: 'Book'),
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

  callback(bookStartTime, bookEndTime, isSelected) {
    setState(() {
      _bookstarttime = bookStartTime;
      _bookendtime = bookEndTime;
      print('Booking date $_bookstarttime   $_bookendtime');
      print('Booking isSelected $isSelected');
      for (var i = 0; i < slotsList.length; i++) {
        var slot = slotsList[i];
        if (slot.startTime == bookStartTime) {
          slot.isSelect = isSelected;
        } else {
          slot.isSelect = false;
        }
        slotsList[i] = slot;
      }
    });
  }

  Future<void> bookTicket() async {
    if (_bookstarttime != null && _bookendtime != null) {
      var requestMap = new Map<String, dynamic>();
      requestMap['retailer_id'] = widget.retailerid;
      requestMap['customer_id'] = await Apppreferences().getUserId();
      requestMap['booking_date'] = bookDate;
      requestMap['book_start_time'] = _bookstarttime;
      requestMap['book_end_time'] = _bookendtime;
      requestMap['app_os'] = await Util().getDeviceOS();
      requestMap['app_version'] = await Util().getAppVersion();

      _bookTicketBloc.add(BookButtonEvent(requestMap: requestMap));
    } else {
      Util().showToast(context, "Please select Time slot");
    }
  }
}
