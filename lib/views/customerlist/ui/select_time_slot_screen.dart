import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_bloc.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_event.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket_state.dart';
import 'package:shoptoken/views/booktickets/ui/book_confirm.dart';
import 'package:shoptoken/views/home/ui/home_screen.dart';
import 'package:shoptoken/widgets/button.dart';
import 'package:shoptoken/widgets/text_style.dart';

import 'customerList_result.dart';

class SelectTimeSlotScreen extends StatefulWidget {
  SelectTimeSlotScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectTimeSlotState createState() => new _SelectTimeSlotState();
}

class _SelectTimeSlotState extends State<SelectTimeSlotScreen> {
  List<BookSlots> slotsList;

  BookTicketBloc _bookTicketBloc;

  @override
  void initState() {
    super.initState();
    _bookTicketBloc = BlocProvider.of<BookTicketBloc>(context);

    slotsList = new List<BookSlots>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookTicketBloc, BookTicketState>(
      listener: (BuildContext context, BookTicketState state) {
        if (state is SlotListSuccess) {
          print(state.result);
          slotsList = state.result.data;
        }
        if (state is BookTicketSuccess) {
          print(state.result);
          // Dialogs().dismissLoaderDialog(context);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BookConfirmScreen()),
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
                              child: new Text("Select Available Time Slot",
                                  style: getTextLargeStyle()),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: CustomerListResult(
                                  slotsList: slotsList,
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

  void bookTicket() {
    _bookTicketBloc.add(BookButtonEvent());
  }
}
