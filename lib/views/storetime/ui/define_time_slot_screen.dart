import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/models/getallslots.dart';
import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/utils/util_page.dart';
import 'package:Retailer/views/booktickets/bloc/bookticket_bloc.dart';
import 'package:Retailer/views/booktickets/bloc/bookticket_event.dart';
import 'package:Retailer/views/booktickets/bloc/bookticket_state.dart';
import 'package:Retailer/views/booktickets/ui/book_confirm.dart';
import 'package:Retailer/views/home/ui/home_screen.dart';
import 'package:Retailer/widgets/button.dart';
import 'package:Retailer/widgets/text_style.dart';

class SelectUserSlotScreen extends StatefulWidget {
  SelectUserSlotScreen({Key key, this.retailerid}) : super(key: key);
  final int retailerid;

  @override
  _SelectTimeSlotState createState() => new _SelectTimeSlotState();
}

class _SelectTimeSlotState extends State<SelectUserSlotScreen> {
  List<SlotData> slotsList;

  BookTicketBloc _bookTicketBloc;

  String _bookstarttime;
  String _bookendtime;

  String bookDate;

  int dropdownValue;

  @override
  void initState() {
    super.initState();
    _bookTicketBloc = BlocProvider.of<BookTicketBloc>(context);

    slotsList = new List<SlotData>();
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
    return BlocListener<BookTicketBloc, BookTicketState>(
      listener: (BuildContext context, BookTicketState state) {
        if (state is SlotListSuccess) {
          print(state.result);
          slotsList = state.result.nearshopresult.data;
        }
        if (state is SelectDateSuccess) {
          print(state.bookDate);
          bookDate = state.bookDate;
        }
        if (state is BookTicketSuccess) {
          print(state.result);
          // Dialogs().dismissLoaderDialog(context);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BookConfirmScreen(bookSlotsResponse: state.result)),
              (Route<dynamic> route) => route is HomeScreen);
        }
      },
      child: BlocBuilder<BookTicketBloc, BookTicketState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, BookTicketState state) {
          if (state is SlotListInProgress) {
            return Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(child: CircularProgressIndicator()));
          }
          if (state is SlotListFailure) {
            return SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            );
          }
          if (state is BookTicketInProgress) {
            Dialogs().showLoaderDialog(context);
          }
          if (state is BookTicketFailure) {
            return SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            );
          }
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
                              value: dropdownValue,
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
                                  dropdownValue = newValue;
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
    requestMap['retailer_id'] = widget.retailerid;
    requestMap['book_start_time'] = _bookstarttime;
    requestMap['book_end_time'] = _bookendtime;
    requestMap['app_os'] = await Util().getDeviceOS();
    requestMap['app_version'] = await Util().getAppVersion();

    _bookTicketBloc.add(BookButtonEvent(requestMap: requestMap));
  }
}
