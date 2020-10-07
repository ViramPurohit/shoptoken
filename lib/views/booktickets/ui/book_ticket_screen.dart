import 'package:flutter/material.dart';
import 'package:Retailer/views/booktickets/ui/select_time_slot_screen.dart';

import 'datepicker_screen.dart';

class BookTicketScreen extends StatefulWidget {
  final int retailerid;

  //requiring the list of todos
  BookTicketScreen({Key key, @required this.retailerid}) : super(key: key);

  @override
  _BookTicketScreen createState() => new _BookTicketScreen();
}

class _BookTicketScreen extends State<BookTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Ticket'),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[
          DateSlotPicker(retailerid: widget.retailerid),
          SelectTimeSlotScreen(retailerid: widget.retailerid)
        ],
      )))),
    );
  }
}
