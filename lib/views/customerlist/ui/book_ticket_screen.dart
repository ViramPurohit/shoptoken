import 'package:flutter/material.dart';
import 'package:Retailer/views/booktickets/ui/select_time_slot_screen.dart';

class BookTicketScreen extends StatefulWidget {
  final int shopid;

  //requiring the list of todos
  BookTicketScreen({Key key, @required this.shopid}) : super(key: key);

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
        children: <Widget>[SelectTimeSlotScreen()],
      )))),
    );
  }
}
