import 'package:flutter/material.dart';
import 'package:Retailer/views/booktickets/ui/select_time_slot_screen.dart';

import 'datepicker_screen.dart';

class BookTicketScreen extends StatefulWidget {
  //requiring the list of todos
  BookTicketScreen({Key key}) : super(key: key);

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
          DateSlotPicker(retailerid: 1),
          SelectTimeSlotScreen(retailerid: 1)
        ],
      )))),
    );
  }
}
